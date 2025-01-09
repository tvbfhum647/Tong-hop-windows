#!/bin/bash

# Cảnh báo
echo "CẢNH BÁO, KHI CHẠY BẢN NÀY VUI LÒNG CÀI SẴN TAILSCALE VÀ TẢI SẴN VIRT-VIEWER TRÊN MÁY ĐỂ CÓ THỂ NGHE NHẠC TRÊN VNC"
echo "chờ 5s để tiếp tục"
sleep 5
SPICE_PORT=5924

# Cập nhật danh sách gói và cài đặt QEMU-KVM
echo "Đang cập nhật danh sách gói..."
sudo apt update
sudo apt install -y qemu-kvm unzip cpulimit python3-pip
if [ $? -ne 0 ]; then
    echo "Lỗi khi cập nhật và cài đặt các gói cần thiết. Vui lòng kiểm tra lại."
    exit 1
fi

# Kiểm tra xem /mnt đã được mount hay chưa
echo "Kiểm tra phân vùng đã được mount vào /mnt..."
if mount | grep "on /mnt " > /dev/null; then
    echo "Phân vùng đã được mount vào /mnt. Tiếp tục..."
else
    echo "Phân vùng chưa được mount. Đang tìm phân vùng lớn hơn 500GB..."
    partition=$(lsblk -b --output NAME,SIZE,MOUNTPOINT | awk '$2 > 500000000000 && $3 == "" {print $1}' | head -n 1)

    if [ -n "$partition" ]; then
        echo "Đã tìm thấy phân vùng: /dev/$partition"
        sudo mount "/dev/${partition}1" /mnt
        if [ $? -ne 0 ]; then
            echo "Lỗi khi mount phân vùng. Vui lòng kiểm tra lại."
            exit 1
        fi
        echo "Phân vùng /dev/$partition đã được mount vào /mnt."
    else
        echo "Không tìm thấy phân vùng có dung lượng lớn hơn 500GB chưa được mount. Vui lòng kiểm tra lại."
        exit 1
    fi
fi

# Hiển thị menu lựa chọn hệ điều hành


    echo "Bạn đã chọn Windows 11 23H2 (22631.2861)."
    file_url="https://api.cloud.hashicorp.com/vagrant-archivist/v1/object/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyMWZlYWNmYi0xMWY5LTRkMTEtOGM2OC0xMTQ5YmY1NmY2YzIiLCJtb2RlIjoiciIsImZpbGVuYW1lIjoid2luMTFtb2RyZHB3Zl8xLjBfcWVtdV9hbWQ2NC5ib3gifQ.WYMn2onERXAiIk9BHyZtMJZZirZS6H9tzJAC5Sj8KIA"
    file_name="/mnt/a.qcow2"

# Tải file Qcow2
echo "Đang tải file $file_name từ $file_url..."
wget -O "$file_name" "$file_url"
if [ $? -ne 0 ]; then
    echo "Lỗi khi tải file. Vui lòng kiểm tra kết nối mạng hoặc URL."
    exit 1
fi

# Khởi chạy máy ảo với KVM
echo "Đang khởi chạy máy ảo..."
echo "Đã khởi động VM thành công vui lòng tự cài ngrok và mở cổng 5900"
sudo cpulimit -l 80 -- sudo kvm \
    -daemonize \
    -cpu host,+topoext,hv_relaxed,hv_spinlocks=0x1fff,hv-passthrough,+pae,+nx,kvm=on,+svm \
    -smp 2,cores=2 \
    -M q35,usb=on \
    -device usb-tablet \
    -m 4G \
    -device virtio-balloon-pci \
    -vga virtio \
    -net nic,netdev=n0,model=virtio-net-pci \
    -netdev user,id=n0,hostfwd=tcp::3389-:3389 \
    -boot c \
    -device virtio-serial-pci \
    -device virtio-rng-pci \
    -enable-kvm \
    -drive file=/mnt/a.qcow2 \
    -drive if=pflash,format=raw,readonly=off,file=/usr/share/ovmf/OVMF.fd \
    -uuid e47ddb84-fb4d-46f9-b531-14bb15156336 \
    -soundhw hda \
    -chardev spicevmc,id=vdagent,name=vdagent \
    -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
    -spice port=${SPICE_PORT},disable-ticketing

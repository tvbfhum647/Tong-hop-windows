sudo apt install docker-compose -y
sudo wget -O /isos/driver.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.240-1/virtio-win-0.1.240.iso &>/dev/null &
while ps axg | grep -vw grep | grep -w wget > /dev/null; do sleep 1; done
wget -O compose.yaml https://raw.githubusercontent.com/Snhvn/Composefile/main/14-16/compose.yaml
echo "thanh cong, ket noi bang port 5900 ở app VNC"
sudo docker compose up

import gdown

# URL file Google Drive (thay đổi từ dạng "view" sang "uc" để gdown hoạt động)
url = "https://drive.usercontent.google.com/download?id=1k0qImJnCp6Vm0EYo8U9Hwgh7hDTjnGr-&export=download"

# Đường dẫn lưu file sau khi tải
output = "/mnt/win11-1.zip"  # Đường dẫn đầy đủ nơi lưu file

# Tải file
gdown.download(url, output, quiet=False)

print(f"File đã được tải về và lưu tại: {output}")

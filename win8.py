import gdown

# URL file Google Drive (thay đổi từ dạng "view" sang "uc" để gdown hoạt động)
url = "https://drive.google.com/uc?id=1Xjl3SjBd_HLw8JUy6aOtGluLeymxCava"

# Đường dẫn lưu file sau khi tải
output = "/mnt/a.7z"  # Đường dẫn đầy đủ nơi lưu file

# Tải file
gdown.download(url, output, quiet=False)

print(f"File đã được tải về và lưu tại: {output}")

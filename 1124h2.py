import gdown

# URL file Google Drive (thay đổi từ dạng "view" sang "uc" để gdown hoạt động)
url = "https://api.cloud.hashicorp.com/vagrant-archivist/v1/object/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiJsaW51eHVzZXJzZmFrZS9XaW5kb3dzMTEyNEgyLzI0LjIvV2luMTEyNEgyL2QyOTQwOWVhLWFjY2MtMTFlZi05NGM4LTVhOGNhNzBiNzRhNSIsIm1vZGUiOiJyIiwiZmlsZW5hbWUiOiJXaW5kb3dzMTEyNEgyXzI0LjJfV2luMTEyNEgyX2FtZDY0LmJveCJ9.7DD39XJxF8PjIdhHcuEABTPiZbPgq_CEgVHrV9ka_eg"

# Đường dẫn lưu file sau khi tải
output = "/mnt/a.qcow2"  # Đường dẫn đầy đủ nơi lưu file

# Tải file
gdown.download(url, output, quiet=False)

print(f"File đã được tải về và lưu tại: {output}")

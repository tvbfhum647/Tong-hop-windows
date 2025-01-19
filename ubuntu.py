import gdown

# URL file Google Drive (thay đổi từ dạng "view" sang "uc" để gdown hoạt động)
url = "https://api.cloud.hashicorp.com/vagrant-archivist/v1/object/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiI1ZGQ1NmM1OC04ZDQ4LTQ0NzgtOWE1Zi0wYjNmYzgyYzRiNTkiLCJtb2RlIjoiciIsImZpbGVuYW1lIjoidWJ1bnR1c2VydmVyMjJfMC4wX3FlbXVfYW1kNjQuYm94In0.tYprxQPqKwTPaqlfna0u7rIlpD3WYbK03haABvT3KQk"

# Đường dẫn lưu file sau khi tải
output = "/mnt/a.qcow2"  # Đường dẫn đầy đủ nơi lưu file

# Tải file
gdown.download(url, output, quiet=False)

print(f"File đã được tải về và lưu tại: {output}")

import gdown

# URL file Google Drive (thay đổi từ dạng "view" sang "uc" để gdown hoạt động)
url = "https://api.cloud.hashicorp.com/vagrant-archivist/v1/object/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrZXkiOiIyMWZlYWNmYi0xMWY5LTRkMTEtOGM2OC0xMTQ5YmY1NmY2YzIiLCJtb2RlIjoiciIsImZpbGVuYW1lIjoid2luMTFtb2RyZHB3Zl8xLjBfcWVtdV9hbWQ2NC5ib3gifQ.WYMn2onERXAiIk9BHyZtMJZZirZS6H9tzJAC5Sj8KIA"

# Đường dẫn lưu file sau khi tải
output = "/mnt/a.qcow2"  # Đường dẫn đầy đủ nơi lưu file

# Tải file
gdown.download(url, output, quiet=False)

print(f"File đã được tải về và lưu tại: {output}")

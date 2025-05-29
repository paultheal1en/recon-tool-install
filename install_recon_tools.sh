#!/bin/bash

# Cập nhật và nâng cấp hệ thống
echo "Cập nhật hệ thống..."
sudo apt update && sudo apt upgrade -y

# Cài đặt Go (nếu chưa có)
echo "Cài đặt Go..."
if ! command -v go &> /dev/null; then
    sudo apt install golang-go -y
fi

# Cài đặt Nmap
echo "Cài đặt Nmap..."
sudo apt install nmap -y

# Tạo thư mục lưu trữ công cụ
echo "Tạo thư mục lưu trữ công cụ..."
mkdir -p ~/my_tools/bin

# Cài đặt Ffuf
echo "Cài đặt Ffuf..."
go install github.com/ffuf/ffuf/v2@latest
mv ~/go/bin/ffuf ~/my_tools/bin/

# Cài đặt Subfinder
echo "Cài đặt Subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
mv ~/go/bin/subfinder ~/my_tools/bin/

# Cài đặt Httpx
echo "Cài đặt Httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
mv ~/go/bin/httpx ~/my_tools/bin/

# Cài đặt Katana
echo "Cài đặt Katana..."
go install github.com/projectdiscovery/katana/cmd/katana@latestst
mv ~/go/bin/katana ~/my_tools/bin/

# Cài đặt Amass
echo "Cài đặt Amass..."
go install -v github.com/owasp-amass/amass/v4/...@master
mv ~/go/bin/amass ~/my_tools/bin/

# Cài đặt Nuclei
echo "Cài đặt Nuclei..."
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
mv ~/go/bin/nuclei ~/my_tools/bin/

# Thêm thư mục vào PATH nếu chưa có
if ! grep -q "my_tools/bin" ~/.bashrc; then
    echo "Thêm thư mục vào PATH..."
    echo 'export PATH="$HOME/my_tools/bin:$PATH"' >> ~/.bashrc
fi

# Áp dụng PATH mới
source ~/.bashrc

# Kiểm tra cài đặt
echo "Kiểm tra các công cụ đã cài đặt..."
for tool in nmap ffuf subfinder httpx katana amass nuclei; do
    if command -v $tool &> /dev/null; then
        echo "$tool đã được cài đặt thành công."
    else
        echo "Lỗi: $tool không được cài đặt."
    fi
done

echo "Hoàn tất cài đặt các công cụ recon!"
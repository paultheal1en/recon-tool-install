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

# Cài đặt Ffuf
echo "Cài đặt Ffuf..."
go install github.com/ffuf/ffuf@latest
sudo mv ~/go/bin/ffuf /usr/local/bin/

# Cài đặt Subfinder
echo "Cài đặt Subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo mv ~/go/bin/subfinder /usr/local/bin/

# Cài đặt Httpx
echo "Cài đặt Httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
sudo mv ~/go/bin/httpx /usr/local/bin/

# Cài đặt Katana
echo "Cài đặt Katana..."
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
sudo mv ~/go/bin/katana /usr/local/bin/

# Cài đặt Amass
echo "Cài đặt Amass..."
go install -v github.com/OWASP/Amass/v4/...@master
sudo mv ~/go/bin/amass /usr/local/bin/

# Cài đặt Nuclei
echo "Cài đặt Nuclei..."
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
sudo mv ~/go/bin/nuclei /usr/local/bin/

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

echo "Tải SecLists..."
git clone https://github.com/danielmiessler/SecLists.git
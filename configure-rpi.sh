echo "This script updates and installs some necessary softwares. At the end, it will report its IP address for SSH"
# Remove LibreOffice
sudo apt-get -y remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove

# Update softwares
sudo apt-get update
sudo apt-get upgrade

# Install some softwares
sudo apt-get -y install apache2 python python3 git-all

# Enable SSH and VNC
sudo systemctl enable ssh
sudo systemctl enable vncserver-x11-serviced

echo "Your IP address is: "
echo `hostname -I`
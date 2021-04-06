#Install Keyboard Software
git clone https://github.com/Askannz/msi-perkeyrgb.git
cd msi-perkeyrgb/
sudo python3 setup.py install
sudo cp 99-msi-rgb.rules /etc/udev/rules.d/
echo 'Reboot Required'

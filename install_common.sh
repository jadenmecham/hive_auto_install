#Update System
sudo apt update
sudo apt dist-upgrade -y

#Add Repos
sudo add-apt-repository -y ppa:graphics-drivers
sudo apt-add-repository -y ppa:remmina-ppa-team/remmina-next
sudo apt update -y

#Apt install programs
sudo apt install -y git terminator openssh-server python-pip python3-pip net-tools remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice 

#Snap install programs
sudo snap install pycharm-community --classic
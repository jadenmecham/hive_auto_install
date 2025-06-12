#!/bin/bash
SERIAL_NUMBER=$(sudo dmidecode -s system-serial-number)
MFG=$(sudo dmidecode -s system-manufacturer)
MODEL=$(sudo dmidecode -s system-product-name)
if [ "$SERIAL_NUMBER" = "System Serial Number" ]; then
  export SERIAL_NUMBER=""
fi
echo "Manufacturer: $MFG"
echo "Model: $MODEL"
echo "Serial Number: $SERIAL_NUMBER"
echo "Hostname: $HOSTNAME"
echo "SSH host keys:"
awk '{print " - ", $NF}' /etc/ssh/*.pub
read -p "Would you like to change the hostname? [Y/n]: " yn
case $yn in
	[Yy]* ) chgHN=true;;
	[Nn]* ) chgHN=false;;
	"" ) chgHN=true;;
	* ) chgHN=false;;
esac
if $chgHN; then
	read -p "Enter the new hostname: " new_hostname
	if [ -z "$new_hostname" ]; then
	  echo "Error: Hostname cannot be empty."
	  exit 1
	fi
	echo "$new_hostname" | sudo tee /etc/hostname
	sudo sed -i "s/$(hostname)/$new_hostname/" /etc/hosts
	sudo hostnamectl set-hostname "$new_hostname"
fi
read -p "Would you like to regenerate the SSH host keys? [Y/n]: " yn
case $yn in
	[Yy]* ) chgSSH=true;;
	[Nn]* ) chgSSH=false;;
	"" ) chgSSH=true;;
	* ) chgSSH=false;;
esac
if $chgSSH; then
	sudo rm -rf /etc/ssh/ssh_host_*
	source ~/.bashrc
	sudo dpkg-reconfigure openssh-server
fi
if [[ "$MFG" == "Dell Inc." ]]; then
	sudo sh -c 'echo "deb http://oem.archive.canonical.com/ jammy jiayi\n# deb-src http://oem.archive.canonical.com/ jammy jiayi" > /etc/apt/sources.list.d/oem-jiayi-meta.list'
	MODEL=$(sudo dmidecode -s system-product-name)
	if [[ "$MODEL" == "Precision 3660" ]]; then
		sudo sh -c 'echo "deb http://dell.archive.canonical.com/ jammy somerville\n# deb-src http://dell.archive.canonical.com/ jammy somerville\ndeb http://dell.archive.canonical.com/ jammy somerville-rockruff-rpl\n# deb-src http://dell.archive.canonical.com/ jammy somerville-rockruff-rpl" > /etc/apt/sources.list.d/oem-somerville-rockruff-rpl-meta.list'
		sudo apt update
		sudo apt install -y oem-fix-misc-cnl-backport-iwlwifi-helper oem-somerville-factory-rockruff-rpl-meta
	elif [[ "$MODEL" == "Precision 3680" ]]; then
		sudo sh -c 'echo "deb http://dell.archive.canonical.com/ jammy somerville\n# deb-src http://dell.archive.canonical.com/ jammy somerville\ndeb http://dell.archive.canonical.com/ jammy somerville-rattata\n# deb-src http://dell.archive.canonical.com/ jammy somerville-rattata" >  oem-somerville-rattata-meta.list'
		sudo apt update
		sudo apt install -y oem-somerville-rattata-meta
	fi
fi
source ~/.bashrc
SERIAL_NUMBER=$(sudo dmidecode -s system-serial-number)
if [ "$SERIAL_NUMBER" = "System Serial Number" ]; then
  export SERIAL_NUMBER=""
fi
echo "Updated info:"
echo "Serial Number: $SERIAL_NUMBER"
echo "Hostname: $HOSTNAME"
echo "SSH host keys:"
awk '{print " - ", $NF}' /etc/ssh/*.pub

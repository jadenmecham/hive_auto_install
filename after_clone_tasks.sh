#!/bin/bash
SERIAL_NUMBER=$(sudo dmidecode -s system-serial-number)
if [ "$SERIAL_NUMBER" = "System Serial Number" ]; then
  export SERIAL_NUMBER=""
fi
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
if [ $chgHN ]; then
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
if [ $chgSSH ]; then
	rm -rf /etc/ssh/ssh_host_*
	sudo dpkg-reconfigure -y openssh-server
fi
echo "Updated info:"
echo "Serial Number: $SERIAL_NUMBER"
echo "Hostname: $HOSTNAME"
echo "SSH host keys:"
awk '{print " - ", $NF}' /etc/ssh/*.pub

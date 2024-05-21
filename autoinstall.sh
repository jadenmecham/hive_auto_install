chmod -R 755 ./*.sh
os_release=$(lsb_release -rs)


read -p "Would you like to install ROS? [Y/n]: " yn
case $yn in
	[Yy]* ) ros=true;;
	[Nn]* ) ros=false;;
	"" ) ros=true;;
	* ) ros=false;;
esac
if $ros
then
	if [[ $os_release == "22.04" || $os_release == "20.04" ]]
	then
		read -p "Would you like to install ROS2? [Y/n]: " yn
		case $yn in
			[Yy]* ) ros2=true;;
			[Nn]* ) ros2=false;;
			"" ) ros2=true;;
			* ) ros2=false;;
		esac
	else
		ros2=false
	fi
	read -p "Would you like to install Gazebo? [Y/n]: " yn
	case $yn in
		[Yy]* ) gazebo=true;;
		[Nn]* ) gazebo=false;;
		"" ) gazebo=true;;
		* ) gazebo=false;;
	esac
else
	ros=false
	ros2=false
	gazebo=false
fi

#Disable ipv6
sh ./disable_ipv6.sh

#Update System
sudo apt update -y
sudo apt dist-upgrade -y

#Add Repos
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
sudo add-apt-repository -y ppa:graphics-drivers
sudo apt-add-repository -y ppa:remmina-ppa-team/remmina-next
sudo apt update -y

#Apt install programs
sudo apt install -y git terminator openssh-server python3-pip net-tools remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice libgmock-dev google-chrome-stable

if [[ $os_release == "22.04" ]]; then
	if $ros
	then
		if $ros2
		then
			sh ./ROS/install_ros2_humble.sh
		else
			echo "Ros1 is not supported on 22.04"
		fi
	fi
elif [[ $os_release == "20.04" ]]; then
	sh ./install_2004_utils.sh
	sudo apt install -y exfat-utils
	if $ros
	then
		if $ros2
		then
			sh ./ROS/install_ros2_foxy.sh
		else
			sh ./ROS/install_ros_noetic.sh
			sudo apt install -y python3-catkin*
		fi
	fi
elif [[ $os_release == "18.04" ]]; then
	sudo apt install -y exfat-utils
	sudo apt install python-pip -y
	if $ros
	then
		sh ./ROS/install_ros_melodic.sh
		sudo apt install -y python-catkin-tools
	fi
elif [[ $os_release == "16.04" ]]; then
	sudo apt install -y exfat-utils
	sudo apt install python-pip -y
	if $ros
	then
		sh ./ROS/install_ros_kinetic.sh
		sudo apt install -y python-catkin-tools
	fi
else
	echo "Non-compatible version"
fi
if $gazebo
then
	curl -sSL http://get.gazebosim.org | sh
fi

#Snap install programs
sudo snap install pycharm-community --classic
sudo snap install gitkraken --classic
sudo snap install code --classic

sudo apt autoremove -y

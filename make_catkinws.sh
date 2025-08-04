#!/bin/bash

# make initial catkin workspace

sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade

cd ~/
mkdir --parents catkin_ws/src
cd catkin_ws
catkin init
catkin build
source ~/catkin_ws/devel/setup.bash

# Now, install all catkin packages
cd
cd catkin_ws/src

# vicon_bridge
git clone https://github.com/jadenmecham/vicon_bridge.git

# mavros
git clone https://github.com/Alopez6991/vrpn_mavros.git

# phidgets
git clone -b noetic https://github.com/ros-drivers/phidgets_drivers.git
rosdep install phidgets_drivers
git clone -b noetic https://github.com/ccny-ros-pkg/imu_tools.git

# trisonica
git clone https://github.com/vanbreugel-lab/trisonica_ros.git

# realsense
sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
sudo apt-get install git wget cmake build-essential
sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
./scripts/setup_udev_rules.sh
./scripts/patch-realsense-ubuntu-lts-hwe.sh
mkdir build && cd build
cmake ../
cmake ../ -DBUILD_EXAMPLES=true
sudo make uninstall && make clean && make && sudo make install

# build
catkin build
source ~/catkin_ws/devel/setup.bash

# reboot
read -r -p "Would you like to reboot now (recommended)? [Y/n] " inputReboot
case $inputReboot in
    [yY][eE][sS]|[yY]|"")
        echo "Rebooting now..."
        sudo reboot
        ;;
    [nN][oO]|[nN])
        echo "Reboot skipped. Please reboot manually later."
        ;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
esac

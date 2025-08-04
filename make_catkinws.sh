#!/bin/bash

# make initial catkin workspace

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



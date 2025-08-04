#!/bin/bash

# Install MAVROS and Extras
sudo apt-get install -y ros-noetic-mavros ros-noetic-mavros-extras

# Install GeographicLib Datasets (needed for MAVROS)
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
chmod a+x install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh
rm install_geographiclib_datasets.sh  # Clean up

# Install RQT and related plugins
sudo apt-get install -y ros-noetic-rqt ros-noetic-rqt-common-plugins ros-noetic-rqt-robot-plugins

# Clone PX4-Autopilot repository (recursive)
git clone https://github.com/PX4/PX4-Autopilot.git --recursive

# Run PX4 Ubuntu setup script
bash ./PX4-Autopilot/Tools/setup/ubuntu.sh

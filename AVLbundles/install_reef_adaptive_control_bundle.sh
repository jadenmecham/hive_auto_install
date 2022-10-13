rai=$(pwd)
sudo apt -y install ros-$ROS_DISTRO-sophus ros-$ROS_DISTRO-ddynamic-reconfigure libceres-dev
sh ../install_librealsense.sh
cd rai
sh ../install_g2o.sh
mkdir -p ~/adaptive_ws/src
cd ~/adaptive_ws/src
catkin_init_workspace
git clone https://github.com/uf-reef-avl/reef_adaptive_control_bundle
cd reef_adaptive_control_bundle
git submodule update --init --recursive
cd ~/adaptive_ws/src/reef_adaptive_control_bundle/realsense-ros/
git reset --hard development
cd ~/adaptive_ws/
catkin build
catkin build
source devel/setup.bash
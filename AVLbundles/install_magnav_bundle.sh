sudo apt install -y libgmock-dev ros-$ROS_DISTRO-kobuki* ros-$ROS_DISTRO-base-local-planner ros-$ROS_DISTRO-move-base-msgs ros-$ROS_DISTRO-ecl-streams
mkdir -p ~/magnav_ws/src
cd ~/magnav_ws/src/
catkin_init_workspace
git clone http://10.251.72.180/magnav/magnavbundle.git
cd ~/magnav_ws/src/magnavbundle/
git submodule update --init --recursive
cd ~/magnav_ws/src/
git clone http://10.251.72.180/torque_flight/torque_flight.git
cd ~/magnav_ws/src/torque_flight/
git submodule update --init --recursive
cd ~/magnav_ws/src/
git clone https://github.com/yujinrobot/yocs_msgs.git
git clone https://github.com/yujinrobot/yujin_ocs.git
git clone https://github.com/machinekoder/ar_track_alvar.git -b noetic-devel
cd ~/magnav_ws/
catkin build
source devel/setup.bash
sh ../install_turtledep.sh
sudo apt install -y ros-$ROS_DISTRO-kobuki* ros-$ROS_DISTRO-base-local-planner ros-$ROS_DISTRO-move-base-msgs ros-$ROS_DISTRO-ecl-streams
mkdir -p ~/turtle_ws/src
cd ~/turtle_ws/src/
catkin_init_workspace
cd ~/turtle_ws/src/
git clone http://10.251.72.180/torque_flight/torque_flight.git
cd ~/turtle_ws/src/torque_flight/
git submodule update --init --recursive
cd ~/turtle_ws/src/
git clone https://github.com/yujinrobot/yocs_msgs.git
git clone https://github.com/yujinrobot/yujin_ocs.git
git clone https://github.com/machinekoder/ar_track_alvar.git -b noetic-devel
git clone http://10.251.72.180/infrastructure/reef_msgs.git
git clone http://10.251.72.180/AVL-Summer-18/turtlebot_PID.git
git clone http://10.251.72.180/AVL-Summer-18/setpoint_generator
cd ~/turtle_ws/
catkin build
source devel/setup.bash
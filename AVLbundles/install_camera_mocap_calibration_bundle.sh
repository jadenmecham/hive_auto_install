mkdir -p calibration_ws/src
cd calibration_ws/src/
catkin_init_workspace
git clone https://github.com/uf-reef-avl/camera_mocap_calibration_bundle.git
cd camera_mocap_calibration_bundle/
git submodule update --init --recursive
sudo apt install ros-melodic-ecl-eigen
sudo apt-get install ros-melodic-openni2-launch ros-melodic-openni2-camera ros-melodic-libuvc-camera ros-melodic-uvc-camera
cd ../.. && catkin build
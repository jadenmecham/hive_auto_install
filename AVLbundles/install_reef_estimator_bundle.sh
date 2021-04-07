mkdir -p estimator_ws/src
cd estimator_ws/src/
catkin_init_workspace
git clone https://github.com/uf-reef-avl/reef_estimator_bundle
cd estimator_bundle
git submodule update --init --recursive
sudo apt install -y libuvc-dev ros-melodic-joy* libsuitesparse-dev libeigen3-dev libsdl1.2-dev
cd ../.. && catkin build
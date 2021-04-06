mkdir -p adaptive_ws/src
cd adaptive_ws/src
catkin_init_workspace
git clone https://github.com/uf-reef-avl/reef_adaptive_control_bundle
cd reef_adaptive_control_bundle
git submodule update --init --recursive
cd ../..
catkin build -j 1
source devel/setup.bash
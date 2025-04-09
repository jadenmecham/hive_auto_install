# Configure ROS One apt repository
sudo apt install -y curl
sudo curl -sSL https://ros.packages.techfak.net/gpg.key -o /etc/apt/keyrings/ros-one-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros-one-keyring.gpg] https://ros.packages.techfak.net $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros1.list
echo "# deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros-one-keyring.gpg] https://ros.packages.techfak.net $(lsb_release -cs) main-dbg" | sudo tee -a /etc/apt/sources.list.d/ros1.list

# Install and setup rosdep
# Do not install python3-rosdep2, which is an outdated version of rosdep shipped via the Ubuntu repositories (instead of ROS)!
sudo apt update
sudo apt install -y python3-rosdep
sudo rosdep init

# Define custom rosdep package mapping
echo "yaml https://ros.packages.techfak.net/ros-one.yaml ubuntu" | sudo tee /etc/ros/rosdep/sources.list.d/1-ros-one.list
rosdep update

# Install packages, e.g. ROS desktop
sudo apt install -y ros-one-desktop

grep -q -F '#source /opt/ros/one/setup.bash' ~/.bashrc || echo "#source /opt/ros/one/setup.bash" >> ~/.bashrc

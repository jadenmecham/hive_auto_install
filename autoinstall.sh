read -r -p "Would you like to install ROS? [Y/n] " input
 
case $input in
[yY][eE][sS]|[yY])
    ros=true
    read -r -p "Would you like to install Gazebo? [Y/n] " input2
    case $input2 in
    [yY][eE][sS]|[yY]) gazebo=true;;
    [nN][oO]|[nN])gazebo=false;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
    esac
    read -r -p "Would you like to install the Adaptive Control Bundle? [Y/n] " input3
    case $input3 in
    [yY][eE][sS]|[yY]) adaptive=true;;
    [nN][oO]|[nN])adaptive=false;;
    esac
;;
[nN][oO]|[nN])
ros=false
gazebo=false
adaptive=false
;;
*)
    echo "Invalid input..."
    exit 1
    ;;
esac

#Update System
sudo apt update -y
sudo apt dist-upgrade -y

#Add Repos
sudo add-apt-repository -y ppa:graphics-drivers
sudo apt-add-repository -y ppa:remmina-ppa-team/remmina-next
sudo apt update -y

#Apt install programs
sudo apt install -y git terminator exfat-utils openssh-server python3-pip net-tools remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice

echo $ros
if [[ $(lsb_release -rs) == "20.04" ]]
then
    sudo apt install python-is-python3
    echo "alias pip=pip3" >> ~/.bashrc
    if $ros
    then
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
        sudo apt update -y
        sudo apt install ros-noetic-desktop-full -y
        sudo apt install ros-noetic-joy* ros-noetic-eigen-stl
        sudo echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
    fi
elif [[ $(lsb_release -rs) == "18.04" ]]
then
    sudo apt install python-pip -y
    if $ros
    then
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
        sudo apt update -y
        sudo apt install ros-melodic-desktop-full -y
        sudo rosdep init
        rosdep update
        echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential -y
        sudo apt install ros-melodic-joy* ros-melodic-eigen-stl
    fi
elif [[ $(lsb_release -rs) == "16.04" ]]
then
    sudo apt install python-pip -y
    if $ros
    then
        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
        sudo apt update -y
        sudo apt install ros-kinetic-desktop-full -y
        sudo rosdep init
        rosdep update
        echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools -y
        sudo apt-get install ros-kinetic-turtlebot ros-kinetic-turtlebot-gazebo ros-kinetic-turtlebot-apps ros-kinetic-turtlebot-interactions ros-kinetic-turtlebot-simulator ros-kinetic-kobuki-ftdi ros-kinetic-ar-track-alvar-msgs -y
    fi
else
    echo "Non-compatible version"
fi
if $ros
then
    sudo apt install -y python-catkin-tools
fi
if $gazebo
then
    curl -sSL http://get.gazebosim.org | sh
fi
if $adaptive
then
    mkdir -p adaptive_ws/src
    cd adaptive_ws/src
    catkin_init_workspace
    git clone https://github.com/uf-reef-avl/reef_adaptive_control_bundle
    cd reef_adaptive_control_bundle
    git submodule update --init --recursive
    cd ../..
    catkin build -j 1
    source devel/setup.bash
fi
#Snap install programs
sudo snap install pycharm-community --classic

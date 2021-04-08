chmod -R 755 ./*.sh
#test
read -r -p "Would you like to install ROS? [Y/n] " inputROS
case $inputROS in
[yY][eE][sS]|[yY])
    ros=true
    read -r -p "Would you like to install Gazebo? [Y/n] " inputGazebo
    case $inputGazebo in
    [yY][eE][sS]|[yY]) gazebo=true;;
    [nN][oO]|[nN])gazebo=false;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
    esac
    read -r -p "Is this a Turtlebot? [Y/n] " inputTurtle
    case $inputTurtle in
    [yY][eE][sS]|[yY]) turtlebot=true;;
    [nN][oO]|[nN]) turtlebot=false;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
    esac
    read -r -p "Is this a Quadrotor? [Y/n] " inputQuad
    case $inputQuad in
    [yY][eE][sS]|[yY])
        quadrotor=true
        read -r -p "Would you like to install the Adaptive Control Bundle? [Y/n] " inputAdaptive
        case $inputAdaptive in
        [yY][eE][sS]|[yY]) adaptive=true;;
        [nN][oO]|[nN])adaptive=false;;
        *)
            echo "Invalid input..."
            exit 1
            ;;
        esac
        ;;
    [nN][oO]|[nN])
        quadrotor=false
        adaptive=false
        ;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
    esac
;;
[nN][oO]|[nN])
    ros=false
    gazebo=false
    adaptive=false
    turtlebot=false
    quadrotor=false
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
    sh ./install_2004_utils.sh
    if $ros
    then
        sh ./ROS/install_ros_noetic.sh
    fi
elif [[ $(lsb_release -rs) == "18.04" ]]
then
    sudo apt install python-pip -y
    if $ros
    then
        sh ./ROS/install_ros_melodic.sh
    fi
elif [[ $(lsb_release -rs) == "16.04" ]]
then
    sudo apt install python-pip -y
    if $ros
    then
        sh ./ROS/install_ros_kinetic.sh
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
if $turtlebot
then
    sh ./install_turtledep.sh
fi
if $quadrotor
then
   #wip
   echo "test"
fi
if $adaptive
then
    sh ./AVLbundles/install_reef_adaptive_control_bundle.sh
fi
#Snap install programs
sudo snap install pycharm-community --classic

sudo apt autoremove -y

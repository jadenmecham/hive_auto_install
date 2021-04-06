if [[ $(lsb_release -rs) == "18.04" ]]
then
    sudo apt install -y ros-melodic-kobuki* ros-melodic-yocs* ros-melodic-eigen-stl-containers ros-melodic-ecl* ros-melodic-joy* ros-melodic-turtlebot*
elif [[ $(lsb_release -rs) == "16.04" ]]
then
    sudo apt install -y ros-kinetic-kobuki* ros-kinetic-yocs* ros-kinetic-eigen-stl-containers ros-kinetic-ecl* ros-kinetic-joy* ros-kinetic-turtlebot*
else
    echo "OS not supported"
fi

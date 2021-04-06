cd ~
git clone https://github.com/RainerKuemmerle/g2o
cd g2o
sudo apt-get install -y cmake libeigen3-dev libsuitesparse-dev qtdeclarative5-dev qt5-qmake libqglviewer-dev-qt5 
mkdir build 
cd build 
cmake ../
make
sudo make install


cd ~
git clone https://github.com/borglab/gtsam.git
cd gtsam
git checkout 4.0.3
sudo apt-get install -y cmake libboost-all-dev
mkdir build 
cd build 
cmake ../
make check
make
sudo make install
sudo ldconfig


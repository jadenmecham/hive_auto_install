# bash script for gtsam (c++) installation

#start of script
git clone https://github.com/borglab/gtsam
cd gtsam
git checkout -b 4.0.3
mkdir build && cd build
read -p "Do you want to run unit tests? (this may take a while): " var
var="${var,,}"
cmake ..
if [[ "$var" == "yes" || "$var" == "y" ]]
then
 make check
fi
make -j8
sudo make install
sudo ldconfig

#end of script

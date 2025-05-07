sudo apt update -y
sudo apt dist-upgrade -y
sudo add-apt-repository -y ppa:graphics-drivers
sudo apt update -y
sudo apt install nvidia-driver-570
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda_12.8.0_570.86.10_linux.run
chmod 755 ./cuda_12.8.0_570.86.10_linux.run
sudo sh cuda_12.8.0_570.86.10_linux.run --silent --toolkit
wget https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz
tar -xvf ./cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
sudo sh -c "grep -q -F 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}}' /etc/bash.bashrc || echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}}' >> /etc/bash.bashrc"
sudo sh -c "grep -q -F 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64' /etc/bash.bashrc || echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64' >> /etc/bash.bashrc"
echo "You must reboot before installing pyTorch or Tensorflow!"
read -p "Would you like to reboot immediately and install pyTorch and Tensorflow automatically after reboot? [Y/n]: " yn
case $yn in
	[Yy]* ) reboot=true;;
	[Nn]* ) reboot=false;;
	"" ) reboot=true;;
	* ) reboot=false;;
esac
if [[ $reboot ]]; then
	(sudo crontab -l; echo "@reboot $(pwd)/install_TFpyTorch.sh") | sudo crontab -
	sudo shutdown -r now
fi

#How to install PyTorch and Tensorflow with GPU support
This guide assumes you have run the autoinstall.sh script found at the root of this repo
It also assumes that you have a nvidia gpu in your computer

## Update your system
```
sudo apt update -Y
sudo apt dist-upgrade -Y
```

## Install the Nvidia Driver
```
sudo apt install nvidia-driver-455
```

## Install Cuda Toolkit 11.3
```
wget https://developer.download.nvidia.com/compute/cuda/11.3.0/local_installers/cuda_11.3.0_465.19.01_linux.run
chmod 755 ./cuda_11.3.0_465.19.01_linux.run
sudo sh cuda_11.3.0_465.19.01_linux.run
```
wait a while for it to run
accept eula
unselect the driver
run install
wait for install to finish

## Install Cudnn
Go to the following link to download cudnn https://developer.nvidia.com/rdp/cudnn-download
Login to your Nvidia Developer account (Create one if you don't have one)
Download for 11.x
Local Installer for Linux x86_64 (Tar)
```
tar -xvf ./cudnn (TAB KEY)
sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
```
Add the following two lines to your bashrc
```
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64
```

## Reboot

## Update pip
```
sudo -H pip3 install --upgrade pip
```

## Install Tensorflow
```
pip3 install tensorflow
```

## Verify Tensorflow Installation
```
python3
import tensorflow as tf
tf.test.is_built_with_gpu_support()
tf.test.is_built_with_cuda()
tf.test.gpu_device_name()
tf.test.is_gpu_available()
print(tf.reduce_sum(tf.random.normal([1000, 1000]))) 
```

## Install PyTorch
```
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
```

## Verify PyTorch Installation
```
import torch
torch.cuda.is_available()
torch.cuda.device_count()
torch.cuda.current_device()
torch.cuda.device(0)
torch.cuda.get_device_name(0)
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print('Using device:', device)
print(torch.cuda.get_device_name(0))
torch.rand(10).to(device)
torch.rand(10, device=device)
```
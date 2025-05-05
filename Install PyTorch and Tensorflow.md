# How to install PyTorch and Tensorflow with GPU support
This guide assumes you have run the autoinstall.sh script found at the root of this repo
It also assumes that you have a nvidia gpu in your computer

## Update your system
```
sudo apt update -Y
sudo apt dist-upgrade -Y
```

## Install the Nvidia Driver
```
sudo apt install nvidia-driver-570
```

## Install Cuda Toolkit 12.8
```
wget https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda_12.8.0_570.86.10_linux.run
chmod 755 ./cuda_12.8.0_570.86.10_linux.run
sudo sh cuda_12.8.0_570.86.10_linux.run
```
1. Wait a while for it to run
2. Accept eula
3. Unselect the driver
4. Run install
5. Wait for install to finish

## Install Cudnn
Go to the following link to download cudnn https://developer.nvidia.com/cudnn-downloads
Operating System: Linux
Architecture: x86_64
Distribution: Tarball
CUDA Version: 12
```
wget https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-9.9.0.52_cuda12-archive.tar.xz
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
Check your GPU compute capability here: https://developer.nvidia.com/cuda-gpus
If your system has a GPU with compute capability >= 5.0 & < 7.5 follow these instructions
```
pip3 install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
```
If your system has a GPU with compute capability >= 7.5 follow these instructions
```
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
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

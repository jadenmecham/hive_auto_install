# How to install AMD ROCm and pyTorch for Framework 16

## Installl drivers and ROCm
```
wget https://repo.radeon.com/amdgpu-install/6.3/ubuntu/jammy/amdgpu-install_6.3.60300-1_all.deb
sudo apt install ./amdgpu-install_6.3.60300-1_all.deb
sudo amdgpu-install --usecase=graphics,rocm,hip,mllib
sudo reboot
```


## Add the following to /etc/bash.bashrc
```
export LD_LIBRARY_PATH=/opt/rocm-6.3.0/lib
export HSA_OVERRIDE_GFX_VERSION=11.0.0
export HCC_AMDGPU_TARGET=gfx1100
export PYTORCH_ROCM_ARCH=gfx1100
export TRITON_USE_ROCM=ON
export ROCM_PATH=/opt/rocm-6.3.0
export ROCR_VISIBLE_DEVICES=0
export HIP_VISIBLE_DEVICES=0
export USE_CUDA=0
```

## Install pyTorch
Look here for latest versions https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3/
```
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3/torch-2.4.0%2Brocm6.3.0-cp310-cp310-linux_x86_64.whl
wget https://repo.radeon.com/rocm/manylinux/rocm-rel-6.3/pytorch_triton_rocm-3.0.0%2Brocm6.3.0.75cc27c26a-cp310-cp310-linux_x86_64.whl
sudo pip3 install ./pytorch_triton_rocm-3.0.0+rocm6.3.0.75cc27c26a-cp310-cp310-linux_x86_64.whl
sudo pip3 install ./torch-2.4.0+rocm6.3.0-cp310-cp310-linux_x86_64.whl
```

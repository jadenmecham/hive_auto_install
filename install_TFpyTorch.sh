if [ -n "$CRON" ]; then
  sudo crontab -l | grep -v "@reboot $0/install_TFpyTorch.sh" | sudo crontab -
fi
sudo -H pip3 install --upgrade pip
pip3 install tensorflow
python3 -c "import tensorflow as tf; print(tf.test.is_built_with_gpu_support()); print(tf.test.is_built_with_cuda()); print(tf.test.gpu_device_name()); print(tf.test.is_gpu_available()); print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
COMPUTE_CAPABILITY=$(nvidia-smi --query-gpu=compute_cap --format=csv,noheader)
if [[ $(echo "$COMPUTE_CAPABILITY >= 7.5" | bc -l) ]]; then
  pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
elif [[ $(echo "$COMPUTE_CAPABILITY >= 5.0" | bc -l) -eq 1 ]]; then
  pip3 install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
else
  echo "Non-compatible GPU compute capability $COMPUTE_CAPABILITY"
fi
python3 -c "import torch; print(torch.cuda.is_available()); print(torch.cuda.device_count()); print(torch.cuda.current_device()); print(torch.cuda.device(0)); print(torch.cuda.get_device_name(0)); device = torch.device('cuda' if torch.cuda.is_available() else 'cpu'); print('Using device:', device); print(torch.cuda.get_device_name(0)); print(torch.rand(10).to(device)); print(torch.rand(10, device=device))"

cat etc/sysctl.conf | sudo tee /etc/sysctl.conf
sudo sysctl -p

cat <<EOF | tee -a ~/.ssh/config
Host gpu
  Hostname gpu.cloud9
  User ec2-user
  IdentityFile ~/.ssh/id_gateway
EOF

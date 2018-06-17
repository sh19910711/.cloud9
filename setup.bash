cat etc/sysctl.conf | sudo tee /etc/sysctl.conf
sudo sysctl -p

cat <<EOF | tee -a ~/.ssh/config
Host gpu
  Hostname gpu.cloud9
  User ec2-user
  IdentityFile ~/.ssh/id_gateway

Host t2.small
  Hostname t2.small.cloud9
  User ec2-user
  IdentityFile ~/.ssh/id_gateway
EOF

sudo iptables -A FORWARD -i eth0 -o eth0 -s 10.0.1.0/24 -j ACCEPT
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo service iptables save

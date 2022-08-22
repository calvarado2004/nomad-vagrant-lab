#!/bin/bash

cd $HOME

sudo mkdir -p /mnt/mysql
# Form Consul Cluster
ps -C consul
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall consul
fi
sudo cp /vagrant/consul-config/consul-server-east.hcl /etc/consul.d/consul-server-east.hcl
sudo nohup consul agent --config-file /etc/consul.d/consul-server-east.hcl &>$HOME/consul.log &

# Form Nomad Cluster
ps -C nomad
retval=$?
if [ $retval -eq 0 ]; then
  sudo killall nomad
fi
sudo cp /vagrant/nomad-config/nomad-server-east.hcl /etc/nomad.d/nomad-server-east.hcl
sudo cp /vagrant/nomad-config/peers.json  /etc/nomad.d/peers.json
sudo nohup nomad agent -config /etc/nomad.d/nomad-server-east.hcl &>$HOME/nomad.log &

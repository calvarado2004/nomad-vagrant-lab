# -*- mode: ruby -*-
# vi: set ft=ruby :

NUM_DISKS = 1

ENV["VAGRANT_EXPERIMENTAL"] = "disks"

Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-20.04"


  # 3-node configuration - Region A
  (1..3).each do |i|
    config.vm.define "nomad-a-#{i}" do |n|
      n.vm.provision "shell", path: "node-install-a.sh"


      n.vm.provider "virtualbox" do |vb|
        vb.memory = "6144"
        unless File.exist?("disks/nomad-worker#{i}-disk-kvdb.vdi")
          (1..NUM_DISKS).each do |j|
            vb.customize ["createmedium", "disk", "--filename", "disks/nomad-worker#{i}-disk-0#{j}", "--format", "VDI", "--size", "177152"]
            vb.customize ["storageattach", :id,  "--storagectl", "SATA Controller", "--port", 2, "--device", 0, "--type", "hdd", "--nonrotational", "on", "--medium", "disks/nomad-worker#{i}-disk-0#{j}.vdi" ]
          end
          vb.customize ["createmedium", "disk", "--filename", "disks/nomad-worker#{i}-disk-kvdb", "--format", "VDI", "--size", "51200"]
          vb.customize ["storageattach", :id,  "--storagectl", "SATA Controller", "--port", 3, "--device", 0, "--type", "hdd", "--nonrotational", "on", "--medium", "disks/nomad-worker#{i}-disk-kvdb.vdi" ]
        end
      end


      if i == 1
        # Expose the nomad ports
        n.vm.network "forwarded_port", guest: 4646, host: 4646, auto_correct: true
      end
      n.vm.hostname = "nomad-a-#{i}"
      n.vm.network "private_network", ip: "172.16.1.#{i+100}"
    end
  end
end

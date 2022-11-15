# HashiCorp Nomad - Local Lab Using Vagrant

### Accompanying blog for the initial setup:  https://discoposse.com/2019/11/21/building-a-hashicorp-nomad-cluster-lab-using-vagrant-and-virtualbox/
### Pluralsight course - Getting Started with HashiCorp Nomad:  https://app.pluralsight.com/library/courses/hashicorp-nomad-getting-started/table-of-contents

## What is this?

A simple 3-node or 6-node lab running Ubuntu servers on VirtualBox and each node runs Consul and Nomad servers which can be configured as a cluster.

## Why use this method?

This is a great way to get your feet wet with Nomad in a simplified environment and you also have a chance to mess around with the configurations and commands without risking a cloud (read: money) installation or a production (read: danger!) environment.

## Requirements

There are a few things you need to get this going:

* Vagrant

* VirtualBox

## How to use the Nomad lab configuration

### For 3-node clusters you must rename `Vagrantfile.3node` to `Vagrantfile`
### For 6-node (two region) clusters you must rename `Vagrantfile.6node` to `Vagrantfile`

* Clone this repo (or fork it of you so desire and want to contribute to it)

* Change directory and run a `vagrant status` to check the dependencies are met

* Run a `vagrant up` command and watch the magic happen! (spoiler alert: it's not magic, it's technology)

* Each node will able to run Consul and Nomad 

To start your Nomad cluster just do this: 

* Connect to the first node (either nomad-a-1 or nomad-b-1) using the `vagrant up` using `vagrant ssh <nodename>` where `<nodename>` is the instance name (e.g. nomad-a-1, nomad-b-1).
* Change directory to the /vagrant folder using `cd /vagrant`
* Launch Nomad using the shell script which is `sudo <nodename>.sh` where `<nodename>` is the node you are running on (e.g. `sudo launch-a-1.sh`)
* Connect to the remaining two nodes (nomad-a-2, nomad-a-3) and repeat the process of changing to the /vagrant folder and running the appropriate launch script

```
vagrant up

vagrant ssh nomad-a-1
sudo /vagrant/launch-a-1.sh
exit

vagrant ssh nomad-a-2
sudo /vagrant/launch-a-2.sh
exit

vagrant ssh nomad-a-3
sudo /vagrant/launch-a-3.sh
exit

vagrant status

Current machine states:

nomad-a-1                 running (virtualbox)
nomad-a-2                 running (virtualbox)
nomad-a-3                 running (virtualbox)
```

The first node in each of the set of three will begin as the leader.  The other two node launch scripts have a `nomad server join` command to join the cluster with the first node.  

Once you're used to the commmands, you can start and stop as much as needed.  

Consul is installed but not used for the basic configuration.  More to come on that.

Now you're running!

## Interacting with the Nomad and Consul cluster

Logging into the systems locally can be done 

* You can use some simple commands to get started 
```
nomad node status
```
* To open the Nomad UI use this command on your local machine
```
open http://172.16.1.101:4646
```

![Nomad Cluster](/images/Nomad01.png)

![Nomad Job](/images/NomadJob.png)


## Vault server

* Install Vault on your node if is the first time

```
vagrant ssh nomad-a-1
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault

```

* Enter into nomad-a-1 and unseal Vault

```

cd /vagrant/nomad-vault 

sudo ./start-vault.sh

open http://172.16.1.101:8200


```

Token: s.bDedFc6AEyZiywySWAQkmsLg

Unseal Vault vagrant nomad

Key 1
nDc2NwDs/WZAOK/sB5xOyCDJTdYPerOivHn7Kji3uKfN

Key 2
5XOloZhq3uMZh36/jpAOEGBqkhcrReKtnz/rgyB1hQaQ

Key 3
PRguU5LtXKiukM+lkFUDXRLErHD5g4Kkeo+jhlUONDBo

Portworx secrets locations

http://172.16.1.101:8200/ui/vault/secrets/secret/list/pwx/nomad-portworx-vagrant/


![Vault on Nomad](/images/Vault.png)


# Portworx

Follow this guide

https://docs.portworx.com/install-with-other/nomad/installation/install-as-a-nomad-job/

The customized Portworx job is the file /vagrant/nomad-portworx/portworx.nomad mounted on your nodes.


![Nomad and Portworx](/images/NomadPX.png)


![Nomad and Portworx](/images/PX-Encrypted.png)

# Portworx Security

Enter into one node and perform the following, the Shared secret is the one that we defined on the portworx.nomad job file:

```
pxctl auth token generate --auth-config=/vagrant/nomad-portworx/authconfig.yaml --issuer nomad-a.us-east-1  --token-duration=1y --shared-secret N/56bhufvvUSRM1WVAKjHw8ygALPaRQLxddtJl+UgBuafRdtaeehcXwMDmNgOh1U   --output /vagrant/nomad-portworx/self-signed-token.txt

pxctl context create admin --token=$(cat /vagrant/nomad-portworx/self-signed-token.txt)

pxctl status
```
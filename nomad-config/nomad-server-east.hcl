data_dir = "/tmp/nomad/server"

server {
  enabled          = true
  bootstrap_expect = 3
  job_gc_threshold = "2m"
}

datacenter = "Alpharetta"

region = "US-East-1"

advertise {
  http = "{{ GetInterfaceIP `eth1` }}"
  rpc  = "{{ GetInterfaceIP `eth1` }}"
  serf = "{{ GetInterfaceIP `eth1` }}"
}

plugin "raw_exec" {
  config {
    enabled = true
  }
}

client {
  enabled           = true
  network_interface = "eth1"
  servers           = ["172.16.1.101", "172.16.1.102", "172.16.1.103"]
  host_volume "mysql" {
    path      = "/vagrant/mysql"
    read_only = false
  }

}

plugin "docker" {
  config {
    allow_privileged = true
    volumes {
      enabled      = true
    }
  }
}

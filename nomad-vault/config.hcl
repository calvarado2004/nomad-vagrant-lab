storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "172.16.1.101:8200"
  tls_disable = "true"
}

api_addr = "https://172.16.1.101:8200"
cluster_addr = "https://172.16.1.101:8201"
ui = true

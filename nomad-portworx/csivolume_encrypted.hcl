id           = "volume-3"
name         = "px_csi_volume_encrypted"
type         = "csi"
plugin_id    = "portworx"
capacity_min = "5G"
capacity_max = "5G"
capability {
  access_mode     = "single-node-reader-only"
  attachment_mode = "file-system"
}
capability {
  access_mode     = "single-node-writer"
  attachment_mode = "file-system"
}

secrets {
  secret_key = "secret/pwx/nomad-portworx-vagrant/px_secret"
  auth-token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhbWFydGluZXpAcHVyZXN0b3JhZ2UuY29tIiwiZXhwIjoxNjQ4NjYyNDg1LCJncm91cHMiOlsiKiJdLCJpYXQiOjE2NDg1NzYwODUsImlzcyI6Im5vbWFkLWEudXMtZWFzdC0xIiwibmFtZSI6IkNhcmxvcyBBbHZhcmFkbyIsInJvbGVzIjpbInN5c3RlbS5hZG1pbiJdLCJzdWIiOiJjYW1hcnRpbmV6QHB1cmVzdG9yYWdlLmNvbS9jYW1hcnRpbmV6In0.KrWX3XTfpPJ89jdNoDzKt_e1c_ElhloG5qLDXGwZojM"
}

parameters {
  secure = "true"
  io_profile = "db_remote"
  io_priority = "high"
  repl = "3"
  cow_ondemand = "false"
  secret_key = "pwx/nomad-portworx-vagrant/px_secret"
}

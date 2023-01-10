id           = "volume-1"
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

mount_options {
  fs_type     = "ext4"
}

secrets {
 auth-token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhbWFydGluZXpAcHVyZXN0b3JhZ2UuY29tIiwiZXhwIjoxNzA0OTA0NDg2LCJncm91cHMiOlsiKiJdLCJpYXQiOjE2NzMzNjg0ODYsImlzcyI6Im5vbWFkLWEudXMtZWFzdC0xIiwibmFtZSI6IkNhcmxvcyBBbHZhcmFkbyIsInJvbGVzIjpbInN5c3RlbS5hZG1pbiJdLCJzdWIiOiJjYW1hcnRpbmV6QHB1cmVzdG9yYWdlLmNvbS9jYW1hcnRpbmV6In0.YJi0km1EqdLz6uPi0Qkn1zDDcL1076hQlzlWyHGoBhs"

}

parameters {
  secure = "true"
  io_profile = "db_remote"
  priority_io = "high"
  repl = "3"
  cow_ondemand = "false"
  secret_key = "px-cluster-key"
  label = "mysql-volume=true"
}

id           = "volume-1"
name         = "px-csi-volume"
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

parameters {
  io_profile = "db_remote"
  io_priority = "high"
  repl = "3"
  cow_ondemand = "false"
  label = "mysql-volume=true"
}

mount_options {
  fs_type     = "ext4"
}

secrets {
  auth-token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhbWFydGluZXpAcHVyZXN0b3JhZ2UuY29tIiwiZXhwIjoxNjk4Mzc3MTkwLCJncm91cHMiOlsiKiJdLCJpYXQiOjE2NjY4NDExOTAsImlzcyI6Im5vbWFkLWEudXMtZWFzdC0xIiwibmFtZSI6IkNhcmxvcyBBbHZhcmFkbyIsInJvbGVzIjpbInN5c3RlbS5hZG1pbiJdLCJzdWIiOiJjYW1hcnRpbmV6QHB1cmVzdG9yYWdlLmNvbS9jYW1hcnRpbmV6In0.LFYx00lR_YmYBai-jExpE7reNo3kLVPukGaL6sybzNo"
}

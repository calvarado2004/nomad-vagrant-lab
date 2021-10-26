id           = "volume-3"
name         = "px_csi_volume_encrypted"
type         = "csi"
plugin_id    = "portworx"
secure       = "true"
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
  auth-token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImNhbWFydGluZXpAcHVyZXN0b3JhZ2UuY29tIiwiZXhwIjoxNjM0OTE5MzM1LCJncm91cHMiOlsiKiJdLCJpYXQiOjE2MzQ4MzI5MzUsImlzcyI6Im5vbWFkLWEudXMtZWFzdC0xIiwibmFtZSI6IkNhcmxvcyBBbHZhcmFkbyIsInJvbGVzIjpbInN5c3RlbS5hZG1pbiJdLCJzdWIiOiJjYW1hcnRpbmV6QHB1cmVzdG9yYWdlLmNvbS9jYW1hcnRpbmV6In0.1QAHdpDUyQe4E9PJ2L_RQ6mSVazAfsfxL2vZkhf2ZCg"
}

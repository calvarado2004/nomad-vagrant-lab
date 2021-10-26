id           = "volume-1"
name         = "database"
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

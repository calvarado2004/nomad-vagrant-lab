job "periodic-cloudsnap" {
  datacenters = ["Alpharetta"]

  periodic {
    cron             = "*/30 * * * * *"
    prohibit_overlap = true
  }

  type = "batch"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  group "cloudnsnaps-mysql" {
    count = 1
    task "cloudsnap" {
      driver = "raw_exec"
      config {
        command = "bash"
        args = [ "-c", "/usr/bin/sudo /opt/pwx/bin/pxctl cloudsnap backup-group --label mysql-volume=true --cred-id carlos-lab"]
      }
    }
  }
}

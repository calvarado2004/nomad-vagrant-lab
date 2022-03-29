job "px-node-wiper" {
  type        = "batch"
  datacenters = ["Alpharetta"]

  group "px-node-wiper" {
    count = 3

    constraint {
      operator  = "distinct_hosts"
      value     = "true"
    }

    task "px-node-wiper" {
      driver = "docker"
      kill_timeout = "120s"   # allow portworx 2 min to gracefully shut down
      kill_signal = "SIGTERM" # use SIGTERM to shut down the nodes

      # container config
      config {
        image        = "portworx/px-node-wiper:2.5.0"
        network_mode = "host"
        ipc_mode = "host"
        privileged = true
        args = [
            "--removedata"
        ]

        volumes = [
            "/etc/pwx:/etc/pwx",
            "/opt/pwx:/opt/pwx",
            "/proc:/hostproc",
            "/etc/systemd/system:/etc/systemd/system",
            "/var/run/dbus:/var/run/dbus"
        ]
      }

      # resource config
      resources {
        cpu    = 1024
        memory = 2048
      }
    }
  }
}

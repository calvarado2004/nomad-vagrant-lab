job "portworx" {
  type        = "service"
  datacenters = ["Alpharetta"]
  
  group "portworx" {
    count = 3


    constraint {
      operator  = "distinct_hosts"
      value     = "true"
    }

    # restart policy for failed portworx tasks
    restart {
      attempts = 3
      delay    = "30s"
      interval = "15m"
      mode     = "fail"
    }

    # how to handle upgrades of portworx instances
    update {
      max_parallel     = 1
      health_check     = "checks"
      min_healthy_time = "10s"
      healthy_deadline = "20m"
      progress_deadline = "21m"
      auto_revert      = true
      canary           = 0
      stagger          = "300s"
    }



    network {
      port "portworx" {
        static = "9015"
      }
    }


    task "px-node" {
      driver = "docker"
      user = "root"
      kill_timeout = "600s"   # allow portworx 2 min to gracefully shut down
      kill_signal = "SIGTERM" # use SIGTERM to shut down the nodes

      # consul service check for portworx instances
      service {
        name = "portworx"
        check {
          port     = "portworx"
          type     = "http"
          path     = "/health"
          interval = "15s"
          timeout  = "5s"
        }
      }

      # setup environment variables for px-nodes
      env {
        AUTO_NODE_RECOVERY_TIMEOUT_IN_SECS = "1500"
        PX_TEMPLATE_VERSION                = "V4"
        CSI_ENDPOINT                       = "unix://var/lib/osd/csi/csi.sock"
        PORTWORX_AUTH_SYSTEM_KEY           = "hX5E8+CG6uSEGB2yxiHJ/1shxxyGm3Ho/JAWkgqz+QHDy/Qd/mi4ZS4ymHFVtlzM"
        PORTWORX_AUTH_JWT_SHAREDSECRET     = "N/56bhufvvUSRM1WVAKjHw8ygALPaRQLxddtJl+UgBuafRdtaeehcXwMDmNgOh1U"
        PORTWORX_AUTH_JWT_ISSUER           = "nomad-a.us-east-1"
        VAULT_ADDR                         = "http://172.16.1.101:8200/"
        VAULT_TOKEN                        = "s.bDedFc6AEyZiywySWAQkmsLg"
      }


      # container config
      config {
        image        = "portworx/oci-monitor:2.11.2"
        network_mode = "host"
        ipc_mode = "host"
        privileged = true
        
        # configure your parameters below
        # do not remove the last parameter (needed for health check)
        args = [
            "-c", "nomad-portworx-vagrant",
            "-b",
            "-d", "eth1",
            "-m", "eth1",
            "-s", "/dev/sdb",
            "-k", "consul://127.0.0.1:8500",
            "-kvdb_dev", "/dev/sdc",
            "-secret_type", "vault",
            "-cluster_secret_key", "pwx/nomad-portworx-vagrant/px_secret",
            "--endpoint", "0.0.0.0:9015"
        ]

        volumes = [
            "/var/cores:/var/cores",
            "/var/run/docker.sock:/var/run/docker.sock",
            "/run/containerd:/run/containerd",
            "/etc/pwx:/etc/pwx",
            "/opt/pwx:/opt/pwx",
            "/proc:/host_proc",
            "/etc/systemd/system:/etc/systemd/system",
            "/var/run/log:/var/run/log",
            "/var/log:/var/log",
            "/var/run/dbus:/var/run/dbus"
        ]

      }

      # CSI Driver config
      csi_plugin {
        id        = "portworx"
        type      = "monolith"
        mount_dir = "/var/lib/csi"
        health_timeout = "30m"
      } 

      # resource config
      resources {
        cpu    = 1024
        memory = 2048
      }

    }
  }
}

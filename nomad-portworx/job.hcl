job "mysql-server" {
  datacenters = ["Alpharetta"]
  type        = "service"

  group "mysql-server" {
    count = 1

    volume "mysql" {
      attachment_mode = "file-system"
      access_mode     = "single-node-writer"
      type            = "csi"
      read_only       = false
      source          = "volume-3"
    }

    network {
      port "db" {
        static = 3306
      }
    }

    restart {
      attempts = 10
      interval = "5m"
      delay    = "25s"
      mode     = "delay"
    }

    task "mysql-server" {


      driver = "docker"

      volume_mount {
        volume      = "mysql"
        destination = "/mnt/mysql"
        read_only   = false
      }

      env {
        MYSQL_ROOT_PASSWORD = "password"
        VAULT_ADDR          = "http://172.16.1.101:8200/"
        VAULT_TOKEN         = "s.bDedFc6AEyZiywySWAQkmsLg"
        VAULT_BACKEND_PATH  = "secret"
      }

      config {
        image = "hashicorp/mysql-portworx-demo:latest"
        args  = ["--datadir", "/mnt/mysql/db"]
        ports = ["db"]
      }

      resources {
        cpu    = 500
        memory = 1024
      }

      service {
        name = "mysql-server"
        port = "db"

        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}

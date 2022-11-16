resource "lxd_profile" "podman_lxd_zfs" {
  name = "podman_lxd_zfs"

  config = {
    "security.nesting" = "true"
    "user.user-data": <<-EOT
        #cloud-config
        package_upgrade: true
        packages:
        - podman
        - fuse-overlayfs
        locale: de_DE.UTF-8
        timezone: Europe/Berlin
        runcmd:
        - [touch, /tmp/simos_was_here]
        write_files:
            path: /etc/containers/storage.conf
            content: |
                [storage]
                driver = "overlay"
                runroot = "/run/containers/storage"
                graphroot = "/var/lib/containers/storage"

                [storage.options]
                mount_program = "/usr/bin/fuse-overlayfs"
EOT
  }
  device {
    type = "nic"
    name = "eth0"

    properties = {
      network = "lxdbr0"
    }
  }
  device {
    type = "disk"
    name = "root"

    properties = {
      pool = "default"
      path = "/"
    }
  }
}

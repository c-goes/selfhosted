resource "lxd_profile" "podmanlxdzfs" {
  name = "podmanlxdzfs"

  config = {
    "security.nesting" = "true"
    "user.user-data": <<-EOT
        #cloud-config
        package_update: true
        package_upgrade: true
        locale: de_DE.UTF-8
        timezone: Europe/Berlin
        packages:
            - python3-pip
            - git
        runcmd:
            - pip3 install ansible
            - ansible-pull -U https://github.com/c-goes/selfhosted.git playbooks/lxd_container_nesting_basic.yml
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

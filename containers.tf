resource "lxd_container" "pctr" {
  name      = "pctr"
  image     = "ubuntu:22.04"
  ephemeral = false
  profiles  = ["default", "${lxd_profile.podmanlxdzfs.name}"]
}

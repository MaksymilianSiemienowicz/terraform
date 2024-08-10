resource "proxmox_vm_qemu" "test" {
  name        = "terraforTest"
  vmid        = "601"
  target_node = "pve"
  agent       = 0

  clone   = "Debian12"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "Test"
          size    = 32
        }
      }
    }
  }

}

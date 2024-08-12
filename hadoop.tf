resource "proxmox_vm_qemu" "HADOOP" {

  count = 3

  name        = "HDPVM${count.index + 1}"
  vmid        = "20${count.index + 1}"
  target_node = "pve"
  agent       = 0




  clone   = "ubuntu-cloud"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 4072

  scsihw = "virtio-scsi-pci"

  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "Test"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size      = "35G"
          storage   = "Test"
          iothread  = false
          replicate = false

        }
      }
    }
  }

  boot      = "order=scsi0"
  skip_ipv6 = true

  os_type = "cloud-init"

  ciuser     = "maks"
  cipassword = var.maksPass
  nameserver = "8.8.8.8"
  ipconfig0  = "ip=192.168.0.1${count.index}/24,gw=192.168.0.1"
  sshkeys    = var.SSH

  network {
    model  = "virtio"
    bridge = "vmbr0"

  }



}

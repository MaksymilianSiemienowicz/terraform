resource "proxmox_vm_qemu" "IPA" {

  count = 1 

  name        = "ipavm"
  vmid        = "101"
  target_node = "proxmox"
  agent       = 0

  clone   = "centos-cloud"
  cores   = 1
  sockets = 1
  cpu     = "host"
  memory  = 2036

  scsihw = "virtio-scsi-pci"

  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "HDD3"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size      = "10G"
          storage   = "HDD3"
          iothread  = false
          replicate = false

        }
      }
    }
  }

  boot      = "order=scsi0"
  skip_ipv6 = true

  os_type = "cloud-init"

  ciuser     = var.username
  cipassword = var.userPassword
  nameserver = "8.8.8.8"
  ipconfig0  = "ip=192.168.0.4/24,gw=192.168.0.1"
  sshkeys = var.sshKey
  onboot = true
  network {
    model  = "virtio"
    bridge = "vmbr0"

  }

}

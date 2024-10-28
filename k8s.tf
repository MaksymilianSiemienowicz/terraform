resource "proxmox_vm_qemu" "K8S" {

  count = 3 

  name        = "k8svm${count.index + 1}"
  vmid        = "20${count.index}"
  target_node = "proxmox"
  agent       = 0

  clone   = "ubuntu-cloud"
  cores   = 4
  sockets = 1
  cpu     = "host"
  memory  = 16100

  scsihw = "virtio-scsi-pci"

  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "HDD2"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size      = "40G"
          storage   = "HDD2"
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
  nameserver = "192.168.0.4"
  ipconfig0  = "ip=192.168.0.2${count.index}/24,gw=192.168.0.1"
  sshkeys = var.sshKey

  onboot = true
  network {
    model  = "virtio"
    bridge = "vmbr0"

  }

}

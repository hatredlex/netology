terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.136.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  storage_access_key = var.storage_access_key
  storage_secret_key = var.storage_secret_key
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

locals {
  ssh_key = file(var.ssh_public_key_path)
}

data "yandex_compute_image" "ubuntu_2204" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "main" {
  name = "netology-vpc"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_route_table" "private_route_table" {
  name       = "private-route-table"
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.private_route_table.id
}

resource "yandex_vpc_security_group" "ssh_and_icmp" {
  name       = "ssh-and-icmp"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_compute_instance" "nat_instance" {
  name        = "nat-instance"
  hostname    = "nat-instance"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    ip_address         = "192.168.10.254"
    nat                = true
    security_group_ids = [yandex_vpc_security_group.ssh_and_icmp.id]
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ${var.ssh_user}
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_key}
    EOF
  }
}

resource "yandex_compute_instance" "public_vm" {
  name        = "public-vm"
  hostname    = "public-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204.id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.ssh_and_icmp.id]
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ${var.ssh_user}
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_key}
    EOF
  }
}

resource "yandex_compute_instance" "private_vm" {
  name        = "private-vm"
  hostname    = "private-vm"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204.id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.ssh_and_icmp.id]
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ${var.ssh_user}
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${local.ssh_key}
    EOF
  }
}

### homework 2

# security group для web
resource "yandex_vpc_security_group" "web_sg" {
  name       = "web-sg"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP from internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol          = "TCP"
    description       = "Health checks from load balancer"
    predefined_target = "loadbalancer_healthchecks"
    port              = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Add bucket
resource "yandex_storage_bucket" "image_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
}

resource "yandex_storage_object" "image" {
  bucket       = yandex_storage_bucket.image_bucket.bucket
  key          = "image.jpg"
  source       = var.image_file_path
  content_type = "image/jpeg"
  acl          = "public-read"
}

# service account для Instance Group
resource "yandex_iam_service_account" "ig_sa" {
  name        = "instance-group-sa"
  description = "Service account for Compute Instance Group"
}

resource "yandex_resourcemanager_folder_iam_member" "ig_sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig_sa.id}"
}

# Instance Group с LAMP
resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-group"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.ig_sa.id

  depends_on = [
    yandex_resourcemanager_folder_iam_member.ig_sa_editor,
    yandex_storage_object.image
  ]

  instance_template {
    name        = "lamp-{instance.index}"
    platform_id = "standard-v3"

    resources {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }

    scheduling_policy {
      preemptible = true
    }

    boot_disk {
      mode = "READ_WRITE"

      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 10
        type     = "network-hdd"
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.main.id
      subnet_ids         = [yandex_vpc_subnet.public.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.web_sg.id]
    }

    metadata = {
      user-data = <<-EOF
        #cloud-config
        users:
          - name: ${var.ssh_user}
            groups: sudo
            shell: /bin/bash
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            ssh_authorized_keys:
              - ${local.ssh_key}

        write_files:
          - path: /var/www/html/index.html
            permissions: '0644'
            content: |
              <!DOCTYPE html>
              <html>
              <head>
                <meta charset="UTF-8">
                <title>Netology LAMP</title>
              </head>
              <body>
                <h1>Netology homework: Compute and Load Balancer</h1>
                <p>Instance group with LAMP template.</p>
                <img src="https://storage.yandexcloud.net/${var.bucket_name}/${yandex_storage_object.image.key}" style="max-width: 600px;">
              </body>
              </html>
      EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }

  health_check {
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2

    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name = "lamp-target-group"
  }
}

# Network Load Balancer
resource "yandex_lb_network_load_balancer" "lamp_balancer" {
  name = "lamp-network-load-balancer"

  listener {
    name = "http-listener"
    port = 80

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer[0].target_group_id

    healthcheck {
      name = "http-healthcheck"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
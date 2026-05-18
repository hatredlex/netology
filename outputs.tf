output "nat_instance_public_ip" {
  value = yandex_compute_instance.nat_instance.network_interface[0].nat_ip_address
}

output "nat_instance_internal_ip" {
  value = yandex_compute_instance.nat_instance.network_interface[0].ip_address
}

output "public_vm_public_ip" {
  value = yandex_compute_instance.public_vm.network_interface[0].nat_ip_address
}

output "public_vm_internal_ip" {
  value = yandex_compute_instance.public_vm.network_interface[0].ip_address
}

output "private_vm_internal_ip" {
  value = yandex_compute_instance.private_vm.network_interface[0].ip_address
}

### homework 2

output "bucket_image_url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.image_bucket.bucket}/${yandex_storage_object.image.key}"
}

output "load_balancer_ip" {
  value = one(flatten([
    for listener in yandex_lb_network_load_balancer.lamp_balancer.listener : [
      for address in listener.external_address_spec :
      address.address
    ]
  ]))
}

output "instance_group_id" {
  value = yandex_compute_instance_group.lamp_group.id
}
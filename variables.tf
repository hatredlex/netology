variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "service_account_key_file" {
  type        = string
  description = "Path to service account key file"
}

variable "zone" {
  type        = string
  description = "Yandex Cloud zone"
  default     = "ru-central1-a"
}

variable "ssh_user" {
  type        = string
  description = "SSH user for VMs"
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}
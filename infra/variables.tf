variable "rg_location" {
  description = "Azure resouce group location"
  default     = "westus2"
}

variable "network_address_space" {
  description = "Azure network address space"
  default = [
    "10.0.0.0/16",
  ]
}

variable "subnet_address_prefixes" {
  description = "Azure subnet address prefixes"
  default = [
    "10.0.2.0/24",
  ]
}

variable "vm_size" {
  description = "Azure Linux virtual machine size"
  default     = "Standard_F1"
}

variable "vm_adminuser" {
  description = "Azure Linux virtual machine admin user name"
  default     = "adminuser"
}

variable "vm_source_image_reference" {
  description = "Azure Linux virtual machine source image reference"
  type        = map
  default     = {}
}

variable "vm_os_disk" {
  description = "Azure Linux virtual machine os disk"
  type        = map
  default     = {}
}

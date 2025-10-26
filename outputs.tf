# Outputs
output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vm_name" {
  description = "The name of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}


output "vm_location" {
  description = "The Azure region where the VM is deployed"
  value       = azurerm_linux_virtual_machine.vm.location
}

output "vm_availability_zone" {
  description = "The availability zone where the VM is deployed"
  value       = azurerm_linux_virtual_machine.vm.zone
}

output "ssh_private_key_path" {
  description = "The path to the SSH private key file"
  value       = local_file.private_key.filename
}


output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "ssh_connection_string" {
  description = "SSH connection command"
  value       = "ssh -i vm_key.pem azureuser@${azurerm_public_ip.pip.ip_address}"
}

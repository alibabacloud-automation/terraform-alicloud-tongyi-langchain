output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.tongyi_langchain.vpc_id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.tongyi_langchain.vswitch_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.tongyi_langchain.security_group_id
}

output "nas_file_system_id" {
  description = "The ID of the NAS file system"
  value       = module.tongyi_langchain.nas_file_system_id
}

output "nas_mount_target_domain" {
  description = "The domain name of the NAS mount target"
  value       = module.tongyi_langchain.nas_mount_target_domain
}

output "pai_service_id" {
  description = "The ID of the PAI-EAS service"
  value       = module.tongyi_langchain.pai_service_id
}

output "service_name" {
  description = "The name of the PAI-EAS service"
  value       = module.tongyi_langchain.service_name
}

output "service_status" {
  description = "The status of the PAI-EAS service"
  value       = module.tongyi_langchain.service_status
}

output "create_time" {
  description = "The creation time of the PAI-EAS service"
  value       = module.tongyi_langchain.create_time
}

output "region_id" {
  description = "The ID of the deployment region"
  value       = module.tongyi_langchain.region_id
}
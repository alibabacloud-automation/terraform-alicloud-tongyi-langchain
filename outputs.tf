output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.security_group.id
}

output "nas_file_system_id" {
  description = "The ID of the NAS file system"
  value       = alicloud_nas_file_system.nas_file_system.id
}

output "nas_mount_target_domain" {
  description = "The domain name of the NAS mount target"
  value       = alicloud_nas_mount_target.nas_mount_target.mount_target_domain
}

output "pai_service_id" {
  description = "The ID of the PAI-EAS service"
  value       = alicloud_pai_service.pai_eas.id
}

output "service_name" {
  description = "The name of the PAI-EAS service"
  value       = "${var.common_name_prefix}_qwen_demo"
}

output "service_status" {
  description = "The status of the PAI-EAS service"
  value       = alicloud_pai_service.pai_eas.status
}

output "create_time" {
  description = "The creation time of the PAI-EAS service"
  value       = alicloud_pai_service.pai_eas.create_time
}

output "region_id" {
  description = "The ID of the deployment region"
  value       = data.alicloud_regions.current.regions[0].id
}
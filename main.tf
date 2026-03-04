# Get current region information
data "alicloud_regions" "current" {
  current = true
}

# Local variables for complex logic and default configurations
locals {
  # Default service configuration for PAI-EAS
  default_pai_service_config = jsonencode({
    metadata = {
      name              = var.pai_service_config.name
      instance          = var.pai_service_config.instance_count
      enable_webservice = tostring(var.pai_service_config.enable_webservice)
      cpu               = var.pai_service_config.cpu
      gpu               = var.pai_service_config.gpu
      memory            = var.pai_service_config.memory
    }
    cloud = {
      computing = {
        instance_type = var.pai_service_config.instance_type
      }
    }
    containers = [
      {
        image  = replace(var.pai_service_config.container_image, "{region}", data.alicloud_regions.current.regions[0].id)
        script = "python webui/webui_server.py --port=${var.pai_service_config.container_port} --model-path=${var.pai_service_config.model_path}"
        port   = var.pai_service_config.container_port
      }
    ]
  })
}

# VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
}

# VSwitch
resource "alicloud_vswitch" "vswitch" {
  zone_id      = var.vswitch_config.zone_id
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_config.cidr_block
  vswitch_name = var.vswitch_config.vswitch_name
}

# Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_config.security_group_name
  security_group_type = var.security_group_config.security_group_type
}

# Security Group Rules
resource "alicloud_security_group_rule" "security_group_rules" {
  for_each = var.security_group_rules

  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = each.value.cidr_ip
}

# NAS File System
resource "alicloud_nas_file_system" "nas_file_system" {
  protocol_type    = var.nas_file_system_config.protocol_type
  file_system_type = var.nas_file_system_config.file_system_type
  storage_type     = var.nas_file_system_config.storage_type
  zone_id          = var.nas_file_system_config.zone_id
  description      = var.nas_file_system_config.description
}

# NAS Access Group
resource "alicloud_nas_access_group" "nas_access_group" {
  access_group_type = var.nas_access_group_config.access_group_type
  access_group_name = var.nas_access_group_config.access_group_name
}

# NAS Mount Target
resource "alicloud_nas_mount_target" "nas_mount_target" {
  vpc_id            = alicloud_vpc.vpc.id
  vswitch_id        = alicloud_vswitch.vswitch.id
  network_type      = var.nas_mount_target_config.network_type
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
  file_system_id    = alicloud_nas_file_system.nas_file_system.id

  depends_on = [alicloud_nas_access_rule.nas_access_rule]
}

# NAS Access Rule
resource "alicloud_nas_access_rule" "nas_access_rule" {
  source_cidr_ip    = var.nas_access_rule_config.source_cidr_ip
  access_group_name = alicloud_nas_access_group.nas_access_group.access_group_name
}

# PAI-EAS Service
resource "alicloud_pai_service" "pai_eas" {
  service_config = local.default_pai_service_config

  timeouts {
    create = var.pai_service_config.create_timeout
  }
}
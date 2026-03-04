provider "alicloud" {
  region = var.region
}

# Data source for available zones
data "alicloud_nas_zones" "default" {
  file_system_type = var.nas_file_system_type
}

# Generate random suffix for service name
resource "random_integer" "service_suffix" {
  min = 1000
  max = 9999
}

module "tongyi_langchain" {
  source = "../../"

  common_name_prefix = var.common_name_prefix

  vpc_config = {
    cidr_block = var.vpc_cidr_block
    vpc_name   = var.vpc_name
  }

  vswitch_config = {
    zone_id      = data.alicloud_nas_zones.default.zones[0].zone_id
    cidr_block   = var.vswitch_cidr_block
    vswitch_name = var.vswitch_name
  }

  security_group_config = {
    security_group_name = var.security_group_name
    security_group_type = var.security_group_type
  }

  security_group_rules = var.security_group_rules

  nas_file_system_config = {
    protocol_type    = var.nas_protocol_type
    file_system_type = var.nas_file_system_type
    storage_type     = var.nas_storage_type
    zone_id          = data.alicloud_nas_zones.default.zones[0].zone_id
    description      = var.nas_description
  }

  nas_access_group_config = {
    access_group_type = var.nas_access_group_type
    access_group_name = var.nas_access_group_name
  }

  nas_mount_target_config = {
    network_type = var.nas_network_type
  }

  nas_access_rule_config = {
    source_cidr_ip = var.nas_source_cidr_ip
  }

  pai_service_config = {
    name              = "${var.pai_service_name}_${random_integer.service_suffix.id}"
    instance_count    = var.pai_instance_count
    cpu               = var.pai_cpu
    gpu               = var.pai_gpu
    memory            = var.pai_memory
    instance_type     = var.pai_instance_type
    enable_webservice = var.pai_enable_webservice
    create_timeout    = var.pai_create_timeout
    container_image   = var.pai_container_image
    container_port    = var.pai_container_port
    model_path        = var.pai_model_path
  }
}
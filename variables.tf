variable "common_name_prefix" {
  type        = string
  description = "Common name prefix for all resources"
  default     = "tongyi-langchain"
}

variable "vpc_config" {
  type = object({
    cidr_block = string
    vpc_name   = optional(string, "vpc_qwen_demo")
  })
  description = "Configuration for VPC. The attribute 'cidr_block' is required."
  default = {
    cidr_block = "192.168.0.0/16"
  }
}

variable "vswitch_config" {
  type = object({
    zone_id      = string
    cidr_block   = string
    vswitch_name = optional(string, "vswitch_qwen_demo")
  })
  description = "Configuration for VSwitch. The attributes 'zone_id' and 'cidr_block' are required."
}

variable "security_group_config" {
  type = object({
    security_group_name = optional(string, "sg_qwen_demo")
    security_group_type = optional(string, "normal")
  })
  description = "Configuration for Security Group."
  default     = {}
}

variable "security_group_rules" {
  type = map(object({
    type        = string
    ip_protocol = string
    nic_type    = string
    policy      = string
    port_range  = string
    priority    = number
    cidr_ip     = string
  }))
  description = "Map of security group rules configuration."
  default = {
    allow_http = {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "80/80"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
    allow_https = {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "443/443"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
    allow_rdp = {
      type        = "ingress"
      ip_protocol = "tcp"
      nic_type    = "intranet"
      policy      = "accept"
      port_range  = "3389/3389"
      priority    = 1
      cidr_ip     = "0.0.0.0/0"
    }
  }
}

variable "nas_file_system_config" {
  type = object({
    protocol_type    = optional(string, "NFS")
    file_system_type = optional(string, "standard")
    storage_type     = optional(string, "Performance")
    zone_id          = string
    description      = optional(string, "NAS file system for Qwen and LangChain conversation model")
  })
  description = "Configuration for NAS File System. The attribute 'zone_id' is required."
}

variable "nas_access_group_config" {
  type = object({
    access_group_type = optional(string, "Vpc")
    access_group_name = optional(string, "nas-access-group-qwen-demo")
  })
  description = "Configuration for NAS Access Group."
  default     = {}
}

variable "nas_mount_target_config" {
  type = object({
    network_type = optional(string, "Vpc")
  })
  description = "Configuration for NAS Mount Target."
  default     = {}
}

variable "nas_access_rule_config" {
  type = object({
    source_cidr_ip = optional(string, "0.0.0.0/0")
  })
  description = "Configuration for NAS Access Rule."
  default     = {}
}

variable "pai_service_config" {
  type = object({
    name              = optional(string, "qwen-langchain-service")
    instance_count    = optional(number, 1)
    cpu               = optional(number, 8)
    gpu               = optional(number, 1)
    memory            = optional(number, 30000)
    instance_type     = optional(string, "ml.gu7i.c8m30.1-gu30")
    enable_webservice = optional(bool, true)
    create_timeout    = optional(string, "20m")
    container_image   = optional(string, "eas-registry-vpc.{region}.cr.aliyuncs.com/pai-eas/chat-llm-webui:2.1")
    container_port    = optional(number, 8000)
    model_path        = optional(string, "Qwen/Qwen-7B-Chat")
  })
  description = "Configuration for PAI-EAS service."
  default     = {}
}

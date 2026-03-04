variable "region" {
  type        = string
  description = "The region where to deploy the resources"
  default     = "cn-hangzhou"
}

variable "common_name_prefix" {
  type        = string
  description = "Common name prefix for all resources"
  default     = "tongyi-langchain-example"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "vpc_qwen_demo_example"
}

variable "vswitch_cidr_block" {
  type        = string
  description = "CIDR block for the VSwitch"
  default     = "192.168.0.0/24"
}

variable "vswitch_name" {
  type        = string
  description = "Name of the VSwitch"
  default     = "vswitch_qwen_demo_example"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "sg_qwen_demo_example"
}

variable "security_group_type" {
  type        = string
  description = "Type of the security group"
  default     = "normal"
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
  description = "Map of security group rules configuration"
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

variable "nas_protocol_type" {
  type        = string
  description = "Protocol type for NAS file system"
  default     = "NFS"
}

variable "nas_file_system_type" {
  type        = string
  description = "Type of NAS file system"
  default     = "standard"
}

variable "nas_storage_type" {
  type        = string
  description = "Storage type for NAS file system"
  default     = "Performance"
}

variable "nas_description" {
  type        = string
  description = "Description for NAS file system"
  default     = "NAS文件系统用于Qwen和LangChain对话模型"
}

variable "nas_access_group_type" {
  type        = string
  description = "Type of NAS access group"
  default     = "Vpc"
}

variable "nas_access_group_name" {
  type        = string
  description = "Name of NAS access group"
  default     = "nas-access-group-qwen-demo-example"
}

variable "nas_network_type" {
  type        = string
  description = "Network type for NAS mount target"
  default     = "Vpc"
}

variable "nas_source_cidr_ip" {
  type        = string
  description = "Source CIDR IP for NAS access rule"
  default     = "0.0.0.0/0"
}

variable "pai_service_name" {
  type        = string
  description = "Name of the PAI-EAS service"
  default     = "qwen_langchain_service_example"
}

variable "pai_instance_count" {
  type        = number
  description = "Number of PAI-EAS service instances"
  default     = 1
}

variable "pai_cpu" {
  type        = number
  description = "CPU cores for PAI-EAS service"
  default     = 8
}

variable "pai_gpu" {
  type        = number
  description = "GPU count for PAI-EAS service"
  default     = 1
}

variable "pai_memory" {
  type        = number
  description = "Memory size for PAI-EAS service in MB"
  default     = 30000
}

variable "pai_instance_type" {
  type        = string
  description = "Instance type for PAI-EAS service"
  default     = "ml.gu7i.c8m30.1-gu30"
}

variable "pai_enable_webservice" {
  type        = bool
  description = "Enable webservice for PAI-EAS service"
  default     = true
}

variable "pai_create_timeout" {
  type        = string
  description = "Timeout for creating PAI-EAS service"
  default     = "20m"
}

variable "pai_container_image" {
  type        = string
  description = "Container image for PAI-EAS service. Use {region} as placeholder for region"
  default     = "eas-registry-vpc.{region}.cr.aliyuncs.com/pai-eas/chat-llm-webui:2.1"
}

variable "pai_container_port" {
  type        = number
  description = "Container port for PAI-EAS service"
  default     = 8000
}

variable "pai_model_path" {
  type        = string
  description = "Model path for PAI-EAS service"
  default     = "Qwen/Qwen-7B-Chat"
}
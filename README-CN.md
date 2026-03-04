阿里云通义千问和 LangChain 对话服务 Terraform 模块

# terraform-alicloud-tongyi-langchain

[English](https://github.com/alibabacloud-automation/terraform-alicloud-tongyi-langchain/blob/main/README.md) | 简体中文

在阿里云上创建完整的通义千问和 LangChain 对话服务基础设施的 Terraform 模块。该模块实现了[通义千问和 LangChain 搭建对话服务](https://www.aliyun.com/solution/tech-solution/tongyi-langchain)解决方案，涉及 PAI-EAS、专有网络（VPC）、交换机（VSwitch）和文件存储 NAS 等资源的创建和部署。

## 使用方法

该模块创建一个完整的 AI 对话服务基础设施，包括 PAI-EAS 服务、网络组件和文件存储。您可以使用此模块快速部署基于通义千问和 LangChain 的生产级对话服务。

```terraform
module "tongyi_langchain" {
  source = "alibabacloud-automation/tongyi-langchain/alicloud"

  vswitch_config = {
    zone_id    = "cn-hangzhou-f"
    cidr_block = "192.168.0.0/24"
  }

  nas_file_system_config = {
    zone_id = "cn-hangzhou-f"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-tongyi-langchain/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_nas_access_group.nas_access_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_group) | resource |
| [alicloud_nas_access_rule.nas_access_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_access_rule) | resource |
| [alicloud_nas_file_system.nas_file_system](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_file_system) | resource |
| [alicloud_nas_mount_target.nas_mount_target](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nas_mount_target) | resource |
| [alicloud_pai_service.pai_eas](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/pai_service) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name_prefix"></a> [common\_name\_prefix](#input\_common\_name\_prefix) | Common name prefix for all resources | `string` | `"tongyi-langchain"` | no |
| <a name="input_nas_access_group_config"></a> [nas\_access\_group\_config](#input\_nas\_access\_group\_config) | Configuration for NAS Access Group. | <pre>object({<br/>    access_group_type = optional(string, "Vpc")<br/>    access_group_name = optional(string, "nas-access-group-qwen-demo")<br/>  })</pre> | `{}` | no |
| <a name="input_nas_access_rule_config"></a> [nas\_access\_rule\_config](#input\_nas\_access\_rule\_config) | Configuration for NAS Access Rule. | <pre>object({<br/>    source_cidr_ip = optional(string, "0.0.0.0/0")<br/>  })</pre> | `{}` | no |
| <a name="input_nas_file_system_config"></a> [nas\_file\_system\_config](#input\_nas\_file\_system\_config) | Configuration for NAS File System. The attribute 'zone\_id' is required. | <pre>object({<br/>    protocol_type    = optional(string, "NFS")<br/>    file_system_type = optional(string, "standard")<br/>    storage_type     = optional(string, "Performance")<br/>    zone_id          = string<br/>    description      = optional(string, "NAS file system for Qwen and LangChain conversation model")<br/>  })</pre> | n/a | yes |
| <a name="input_nas_mount_target_config"></a> [nas\_mount\_target\_config](#input\_nas\_mount\_target\_config) | Configuration for NAS Mount Target. | <pre>object({<br/>    network_type = optional(string, "Vpc")<br/>  })</pre> | `{}` | no |
| <a name="input_pai_service_config"></a> [pai\_service\_config](#input\_pai\_service\_config) | Configuration for PAI-EAS service. | <pre>object({<br/>    name              = optional(string, "qwen-langchain-service")<br/>    instance_count    = optional(number, 1)<br/>    cpu               = optional(number, 8)<br/>    gpu               = optional(number, 1)<br/>    memory            = optional(number, 30000)<br/>    instance_type     = optional(string, "ml.gu7i.c8m30.1-gu30")<br/>    enable_webservice = optional(bool, true)<br/>    create_timeout    = optional(string, "20m")<br/>    container_image   = optional(string, "eas-registry-vpc.{region}.cr.aliyuncs.com/pai-eas/chat-llm-webui:2.1")<br/>    container_port    = optional(number, 8000)<br/>    model_path        = optional(string, "Qwen/Qwen-7B-Chat")<br/>  })</pre> | `{}` | no |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | Configuration for Security Group. | <pre>object({<br/>    security_group_name = optional(string, "sg_qwen_demo")<br/>    security_group_type = optional(string, "normal")<br/>  })</pre> | `{}` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Map of security group rules configuration. | <pre>map(object({<br/>    type        = string<br/>    ip_protocol = string<br/>    nic_type    = string<br/>    policy      = string<br/>    port_range  = string<br/>    priority    = number<br/>    cidr_ip     = string<br/>  }))</pre> | <pre>{<br/>  "allow_http": {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "80/80",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  },<br/>  "allow_https": {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "443/443",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  },<br/>  "allow_rdp": {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "3389/3389",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  }<br/>}</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration for VPC. The attribute 'cidr\_block' is required. | <pre>object({<br/>    cidr_block = string<br/>    vpc_name   = optional(string, "vpc_qwen_demo")<br/>  })</pre> | <pre>{<br/>  "cidr_block": "192.168.0.0/16"<br/>}</pre> | no |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | Configuration for VSwitch. The attributes 'zone\_id' and 'cidr\_block' are required. | <pre>object({<br/>    zone_id      = string<br/>    cidr_block   = string<br/>    vswitch_name = optional(string, "vswitch_qwen_demo")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_time"></a> [create\_time](#output\_create\_time) | The creation time of the PAI-EAS service |
| <a name="output_nas_file_system_id"></a> [nas\_file\_system\_id](#output\_nas\_file\_system\_id) | The ID of the NAS file system |
| <a name="output_nas_mount_target_domain"></a> [nas\_mount\_target\_domain](#output\_nas\_mount\_target\_domain) | The domain name of the NAS mount target |
| <a name="output_pai_service_id"></a> [pai\_service\_id](#output\_pai\_service\_id) | The ID of the PAI-EAS service |
| <a name="output_region_id"></a> [region\_id](#output\_region\_id) | The ID of the deployment region |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | The name of the PAI-EAS service |
| <a name="output_service_status"></a> [service\_status](#output\_service\_status) | The status of the PAI-EAS service |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
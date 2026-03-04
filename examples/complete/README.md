# Complete Example

This example demonstrates the complete usage of the Tongyi-LangChain Terraform module. It creates all the necessary resources for building a conversation service with Qwen and LangChain, including VPC, VSwitch, security group, NAS file system, and PAI-EAS service.

## Usage

To run this example, you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources that may cost money. Run `terraform destroy` when you don't need these resources.

## Notes

- Make sure you have the necessary permissions to create PAI-EAS services in your Alibaba Cloud account
- The PAI-EAS service creation may take several minutes to complete
- Ensure the selected zone supports the instance type you want to use
- The default configuration creates a basic setup suitable for testing and development
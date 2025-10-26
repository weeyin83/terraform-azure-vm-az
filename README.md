# Azure VM with Availability Zones - Terraform Configuration

This Terraform configuration deploys Ubuntu virtual machines across Azure availability zones with randomized region selection and complete networking infrastructure.

<a href="https://www.buymeacoffee.com/techielass"> <img align="left" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" height="50" width="210" alt="techielass" /></a></p>

<br><br>

## 🚀 Features

- **Random Region Selection**: Automatically selects from UK West, West Europe, France Central, or Sweden Central
- **Availability Zone Support**: Deploys VMs in specific availability zones for high availability
- **Complete Networking**: Creates VNet, subnet, public IP, and security groups
- **SSH Key Management**: Automatically generates SSH key pairs with proper Windows permissions
- **CAF Compliant Naming**: Uses Azure naming module for consistent, unique resource names
- **Security**: Network security group with SSH access rules

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.9.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured
- An active Azure subscription

## 🛠️ Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd terraform-vm-az-zones
   ```

2. **Log in to Azure**
   ```bash
   az login
   ```

3. **Create terraform.tfvars file**
   ```hcl
   azure_subscription_id = "your-subscription-id"
   availability_zone     = "1"  # Options: "1", "2", or "3"
   ```

4. **Initialize and apply Terraform**
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## 📝 Configuration

### Required Variables

| Variable | Description | Type | Example |
|----------|-------------|------|---------|
| `azure_subscription_id` | Your Azure subscription ID | `string` | `"12345678-1234-1234-1234-123456789012"` |
| `availability_zone` | Azure availability zone (1, 2, or 3) | `string` | `"1"` |

### Supported Azure Regions

The configuration randomly selects from these regions:
- UK West (`ukwest`)
- West Europe (`westeurope`) 
- France Central (`francecentral`)
- Sweden Central (`swedencentral`)

## 📤 Outputs

After deployment, Terraform provides these outputs:

| Output | Description |
|--------|-------------|
| `resource_group_name` | Name of the created resource group |
| `vm_name` | Name of the virtual machine |
| `vm_location` | Azure region where VM is deployed |
| `vm_availability_zone` | Availability zone of the VM |
| `vm_public_ip` | Public IP address of the VM |
| `ssh_connection_string` | Ready-to-use SSH command |
| `ssh_private_key_path` | Path to the SSH private key file |

## 🔐 SSH Connection

After deployment, connect to your VM using:

```bash
ssh -i vm_key.pem azureuser@<public-ip>
```

The SSH connection string is provided in the Terraform outputs.

## 🏗️ Infrastructure Components

- **Resource Group**: Container for all resources
- **Virtual Network**: 10.0.0.0/16 address space
- **Subnet**: 10.0.1.0/24 for VM placement
- **Public IP**: Static IP with Standard SKU
- **Network Security Group**: SSH access on port 22
- **Network Interface**: Connects VM to subnet
- **Linux Virtual Machine**: Ubuntu 22.04 LTS on Standard_B1s
- **SSH Key Pair**: Auto-generated RSA 4096-bit keys

## 🧹 Cleanup

To destroy all created resources:

```bash
terraform destroy
```

## 🔧 Customization

### Changing VM Size
Edit the `size` parameter in `main.tf`:
```hcl
size = "Standard_B2s"  # Change from Standard_B1s
```

### Adding More Regions
Add regions to the `azure_regions` local in `main.tf`:
```hcl
local {
  azure_regions = [
    "ukwest",
    "westeurope", 
    "francecentral",
    "swedencentral",
    "northeurope"  # Add new region
  ]
}
```

### Custom Network Configuration
Modify the address spaces in `main.tf`:
```hcl
address_space    = ["10.1.0.0/16"]  # VNet
address_prefixes = ["10.1.1.0/24"]  # Subnet
```

## 📁 File Structure

```
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── outputs.tf          # Output definitions
├── terraform.tfvars    # Variable values (create this)
├── .gitignore          # Git ignore rules
└── vm_key.pem          # Generated SSH private key
```

## 🔒 Security Considerations

- SSH keys are auto-generated with appropriate permissions
- Network security group restricts access to SSH (port 22) only
- `.tfvars` files are excluded from version control
- Private keys are not committed to repository

## 🐛 Troubleshooting

### Common Issues

1. **Permission denied (publickey)**
   - Ensure `vm_key.pem` has correct permissions: `chmod 600 vm_key.pem`

2. **Azure authentication failed**
   - Run `az login` and ensure you have access to the subscription

3. **Resource quota exceeded**
   - Check your Azure subscription limits for the selected regions

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📞 Support

For issues and questions:
- Create an [issue](../../issues) in this repository
- Check existing [discussions](../../discussions)

---

## Credits

Written by: Sarah Lean

[![YouTube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCQ8U53KvEX2JuCe48MxmV3Q?label=People%20subscribed%20to%20my%20YouTube%20channel&style=social)](https://www.youtube.com/techielass?sub_confirmation=1) [![Twitter Follow](https://img.shields.io/twitter/follow/techielass?label=Twitter%20Followers&style=social)](https://twitter.com/intent/follow?screen_name=techielass)

Find me on:

* My Blog: <https://www.techielass.com>
* Twitter: <https://twitter.com/techielass>
* LinkedIn: <http://uk.linkedin.com/in/sazlean>

## Acknowledgments

- Uses [Azure/naming](https://registry.terraform.io/modules/Azure/naming/azurerm/latest) Terraform module for CAF-compliant resource naming
- Built with Terraform and Azure Resource Manager

**Note**: This configuration is provided as-is. Always review and test in a development environment before using in production.
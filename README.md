# wcmt
modular test

## Infrastructure as Code
### Prerequisites
#### Terraform Version
use [tfenv](https://github.com/tfutils/tfenv) to make sure your terraform version `">= 0.13.5"`
```
tfenv list
```
#### Install the Azure CLI tool
```
brew update && brew install azure-cli
```
#### Authenticate using the Azure CLI
```
az login
```
Your browser window will open and you will be prompted to enter your Azure login credentials. After successful authentication, your terminal will display your subscription information. You do not need to save this output as it is saved in your system for Terraform to use.
```
You have logged in. Now let us find all the subscriptions to which you have access...

[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "your-home-tenant-id",
    "id": "your-id",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Subscription-Name",
    "state": "Enabled",
    "tenantId": "tenant-id",
    "user": {
      "name": "your-username@domain.com",
      "type": "user"
    }
  }
]
```
#### Store Terraform state in Azure Storage
Run below command to create an Azure storage account. Type `yes` at the confirmation prompt to proceed.
```
make gen-tfstate
```
Get the output values for
- storage_account_name: The name of the Azure Storage account.
- container_name: The name of the blob container.

### Apply Terraform Configuration
Run the terraform apply command to apply your configuration. Type `yes` at the confirmation prompt to proceed.
```
make tf-apply
```
---
## API
```
# Run test
make test

# Run local
make run-local

# Run local docker
IMAGETAG=1.0.0 make run-docker
```
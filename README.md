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

# Run locally
make run-local

# Run local docker
make run-docker
```

## CI/CD
### Current process
- Test: the Github action will be auto-triggered when a PR is `opened` or `updated`. It will handle the unit test.
- Build and deploy: the Github action will be auto-triggered when a PR is `merged` and `closed`, it will push the image to Dockerhub when the docker image is built successfully. At last, based on the Github secret configurations(`secrets.HOST`, `secrets.USERNAME`, `secrets.PASSWORD` and `secrets.PORT`), the image will be pulled and running on the target server.
#### Pros
- Straightforward and easy to implement
#### Cons
- Hard to manage Github secrets when the size of the services become large

#### Notes
The remote deployment is comment out and not tested. instead, there is another mock step to simulate the deployment with succeed returned directly.

### Proposal
- Use Github action as CI only - build image and provide CI gate validation(sonar, unit test)
- Integrate any other tool like Jenkins to handle CD process
# Deploy Terraform on Azure Using Github Actions
This repo is a sample to present how to manage a pair of mirrored, prod and staging, infrastructures on Azure by 
Terraform and Github Actions.

Until now, the built architectures have only Docker & Kubernetes environment on Azure, i.e.
1. Azure Container Registry
2. Azure Kubernetes Service

Of course, only these two Azure products cannot 

## 1. Parallel Infrastructure Strategy
### 1.1 Code Level
There are several different strategies to manage terraform code stack behind a pair of parallel infrastructures, such as
1. Two branches
2. Two workspaces
3. Two folders

Because of the simplicity of maintaining, this repo picks the third strategy. Of course, we need assistance from workflows of Github Actions.

### 1.2 Infrastructure Level
There are also different strategies to divide the two environments on Azure. This repo picks one Microsoft recommended strategy: Two Subscriptions in One Account. 

## 2. Code Structure

```
├── .github                                   
│     └── workflows                         <- Includes two .yml files for two workflows managing main branch and staging branch respectively.
│           ├── ...
├── terraform-prod                          <- Incldues terraform files for the Prod Environment on Azure
│     ├── ...   
├── terraform-staging                       <- Incldues terraform files for the Staging Environment on Azure
│     ├── ...                        
├── .gitignore
├── ConfigureRemoteBackendToUseAzureStorageWithAzureCLI.sh      <- Bash commands to build up remote backend for running Terraform
├── LICENSE                                 
└──  README.md                                <- This file.
```

## 3. Usage
To use this repo to build up Azure infrastructures, we need to fulfill the following preconditions:
1. Azure account, two subscriptions and service principals 
2. Terraform account and tokens
3. Prepare a `.env` file in the format of `env_format.txt`
4. Create Github Actions secrets (refer to the yml files in `.github/workflows/`)

### 3.1 Create Remote Backend
Terraform requires a remote backend, i.e. a remote stored `.tfstate` file to sync the code stack and the infrastructure. Since we are 
building on Azure, we need to store it in a blob container on Azure. 

In the file `ConfigureRemoteBackendToUseAzureStorageWithAzureCLI.sh`, the blocks of `az` commends do the following jobs in order:
1. Create a Resource Group
2. Create Storage Account in the Resource Group
3. Create a Container belongs to the Storage Account

The created container will be the "remote backend" storing a `terraform.tfstate` file.

### 3.2 PR to Branch Staging
Opening a PR including editing on folder `terraform-staging` to branch `staging`, committing to the PR, triggers a workflow to run `terraform plan`.
Merging the PR to branch `staging`, triggers `terraform apply` to do the planned building on Azure subscription for staging environment.

### 3.3 PR tp Branch Main
Opening a PR including editing on folder `terraform-prod` to branch `main`, committing to the PR, triggers a workflow to run `terraform plan`.
Merging the PR to branch `main`, triggers `terraform apply` to do the planned building on Azure subscription for prod environment.
#!/bin/bash

# Create resource group
az group create \
  --name "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE" \
  --location "Norway East"

# Create storage group
az storage account create \
  --resource-group "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE" \
  --name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE" \
  --sku Standard_LRS \
  --encryption-services blob

# Create blob container
az storage container create \
  --name "$AZURE_BLOB_CONTAINER_NAME_FOR_TERRAFORM_STATE" \
  --account-name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE"

# Get the storage access key
ACCOUNT_KEY=$(
  az storage account keys list \
    --resource-group "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE" \
    --account-name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE" \
    --query '[0].value' -o tsv
  )

export ARM_ACCESS_KEY=$ACCOUNT_KEY


echo "storage_account_name: $AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE"
echo "container_name: $AZURE_BLOB_CONTAINER_NAME_FOR_TERRAFORM_STATE"

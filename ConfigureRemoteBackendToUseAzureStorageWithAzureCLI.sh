#!/bin/bash

# Create resource group
az group create \
  --subscription "$AZURE_SUBSCRIPTION_ID_PROD"\
  --name "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE_PROD" \
  --location "Norway East"

# Create storage group
az storage account create \
  --resource-group "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE_PROD" \
  --subscription "$AZURE_SUBSCRIPTION_ID_PROD"\
  --name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE_PROD" \
  --sku Standard_LRS \
  --encryption-services blob

# Create blob container
az storage container create \
  --subscription "$AZURE_SUBSCRIPTION_ID_PROD"\
  --name "$AZURE_BLOB_CONTAINER_NAME_FOR_TERRAFORM_STATE_PROD" \
  --account-name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE_PROD"

# Get the storage access key
ACCOUNT_KEY=$(
  az storage account keys list \
    --subscription "$AZURE_SUBSCRIPTION_ID_PROD"\
    --resource-group "$AZURE_RESOURCE_GROUP_FOR_TERRAFORM_STATE_PROD" \
    --account-name "$AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE_PROD" \
    --query '[0].value' -o tsv
  )

export ARM_ACCESS_KEY=$ACCOUNT_KEY


echo "storage_account_name: $AZURE_STORAGE_ACCOUNT_FOR_TERRAFORM_STATE_PROD"
echo "container_name: $AZURE_BLOB_CONTAINER_NAME_FOR_TERRAFORM_STATE_PROD"

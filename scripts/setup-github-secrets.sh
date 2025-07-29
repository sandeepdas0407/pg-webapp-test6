#!/bin/bash

# Script to create Azure Service Principal for GitHub Actions
# Run this script after creating your GitHub repository

echo "Creating Azure Service Principal for GitHub Actions..."

# Set variables
SUBSCRIPTION_ID="f07bc955-3375-4d24-9327-223f77fc24b8"
SP_NAME="github-actions-pg-webapp"
RESOURCE_GROUP="rg-PandG1"

echo "Subscription ID: $SUBSCRIPTION_ID"
echo "Service Principal Name: $SP_NAME"

# Create service principal
echo "Creating service principal..."
SP_OUTPUT=$(az ad sp create-for-rbac \
  --name "$SP_NAME" \
  --role contributor \
  --scopes "/subscriptions/$SUBSCRIPTION_ID" \
  --sdk-auth)

echo ""
echo "=============================================="
echo "Service Principal Created Successfully!"
echo "=============================================="
echo ""
echo "Copy the following JSON and add it as AZURE_CREDENTIALS secret in GitHub:"
echo ""
echo "$SP_OUTPUT"
echo ""

# Extract individual values for easier setup
CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.clientId')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.clientSecret')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenantId')

echo "=============================================="
echo "Individual values for GitHub Secrets:"
echo "=============================================="
echo "AZURE_CREDENTIALS: (Use the entire JSON above)"
echo "AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID"
echo "AZURE_CLIENT_ID: $CLIENT_ID"
echo "AZURE_CLIENT_SECRET: $CLIENT_SECRET"
echo "AZURE_TENANT_ID: $TENANT_ID"
echo "AZURE_ENV_NAME: PandG1"
echo "AZURE_LOCATION: eastus2"
echo ""
echo "=============================================="
echo "Next Steps:"
echo "=============================================="
echo "1. Go to your GitHub repository"
echo "2. Navigate to Settings → Secrets and variables → Actions"
echo "3. Add each of the above values as repository secrets"
echo "4. Push your code to trigger the GitHub Actions workflow"
echo ""

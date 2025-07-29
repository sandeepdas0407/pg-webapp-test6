#!/bin/bash
# Azure Cloud Shell Command - Copy and paste this entire script

echo "🚀 Setting up GitHub Actions for Azure Deployment"

# Variables
SUBSCRIPTION_ID="f07bc955-3375-4d24-9327-223f77fc24b8"
SP_NAME="github-actions-pg-webapp"
REPO="sandeepdas0407/pg-webapp-test6"

# Set subscription
az account set --subscription $SUBSCRIPTION_ID

# Create service principal
echo "Creating service principal..."
SP_OUTPUT=$(az ad sp create-for-rbac \
  --name "$SP_NAME" \
  --role "Contributor" \
  --scopes "/subscriptions/$SUBSCRIPTION_ID" \
  --json-auth)

# Extract values
CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.clientId')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.clientSecret')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenantId')

echo ""
echo "✅ Service Principal Created!"
echo "CLIENT_ID: $CLIENT_ID"
echo "TENANT_ID: $TENANT_ID"
echo ""

# GitHub CLI commands to run locally
echo "🔧 Run these commands locally to set GitHub secrets:"
echo ""
echo "gh secret set AZURE_CLIENT_ID --body \"$CLIENT_ID\" --repo $REPO"
echo "gh secret set AZURE_CLIENT_SECRET --body \"$CLIENT_SECRET\" --repo $REPO"
echo "gh secret set AZURE_TENANT_ID --body \"$TENANT_ID\" --repo $REPO"
echo "gh secret set AZURE_SUBSCRIPTION_ID --body \"$SUBSCRIPTION_ID\" --repo $REPO"
echo ""
echo "🎉 Copy and run the commands above in your local terminal!"

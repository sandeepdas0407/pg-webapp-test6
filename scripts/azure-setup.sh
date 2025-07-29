#!/bin/bash

# Complete Azure Service Principal Setup Script
# Run this in Azure Cloud Shell: https://shell.azure.com

echo "🚀 Creating Azure Service Principal for GitHub Actions"
echo "Repository: sandeepdas0407/pg-webapp-test6"
echo ""

# Set variables
SUBSCRIPTION_ID="f07bc955-3375-4d24-9327-223f77fc24b8"
SP_NAME="github-actions-pg-webapp"

echo "📋 Configuration:"
echo "Subscription ID: $SUBSCRIPTION_ID"
echo "Service Principal Name: $SP_NAME"
echo ""

# Set the subscription
echo "Setting subscription..."
az account set --subscription $SUBSCRIPTION_ID

# Create service principal
echo "Creating service principal..."
SP_OUTPUT=$(az ad sp create-for-rbac \
  --name "$SP_NAME" \
  --role "Contributor" \
  --scopes "/subscriptions/$SUBSCRIPTION_ID" \
  --json-auth)

echo ""
echo "✅ Service Principal Created Successfully!"
echo ""
echo "🔐 GitHub Secrets Configuration:"
echo "Copy these values to GitHub repository secrets:"
echo ""

# Parse the JSON output
CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.clientId')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.clientSecret')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenantId')

echo "AZURE_CLIENT_ID: $CLIENT_ID"
echo "AZURE_CLIENT_SECRET: $CLIENT_SECRET"
echo "AZURE_TENANT_ID: $TENANT_ID"
echo "AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID"

echo ""
echo "📋 GitHub CLI Commands (run these locally):"
echo ""
echo "gh secret set AZURE_CLIENT_ID --body \"$CLIENT_ID\" --repo sandeepdas0407/pg-webapp-test6"
echo "gh secret set AZURE_CLIENT_SECRET --body \"$CLIENT_SECRET\" --repo sandeepdas0407/pg-webapp-test6"
echo "gh secret set AZURE_TENANT_ID --body \"$TENANT_ID\" --repo sandeepdas0407/pg-webapp-test6"
echo "gh secret set AZURE_SUBSCRIPTION_ID --body \"$SUBSCRIPTION_ID\" --repo sandeepdas0407/pg-webapp-test6"

echo ""
echo "🔗 Next Steps:"
echo "1. Copy the GitHub CLI commands above"
echo "2. Run them in your local terminal"
echo "3. Go to: https://github.com/sandeepdas0407/pg-webapp-test6/actions"
echo "4. Trigger a deployment by pushing a change"
echo ""
echo "🌐 Your app will be deployed to:"
echo "https://app-webapp-auvx5tx4cnram.azurewebsites.net"

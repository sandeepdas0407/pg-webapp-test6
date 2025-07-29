#!/bin/bash

# Complete Azure Setup and GitHub Configuration Script
# Run this in Azure Cloud Shell: https://shell.azure.com

echo "🚀 Complete Setup for GitHub Actions Azure Deployment"
echo "Repository: sandeepdas0407/pg-webapp-test6"
echo "Date: $(date)"
echo ""

# Set variables
SUBSCRIPTION_ID="f07bc955-3375-4d24-9327-223f77fc24b8"
SP_NAME="github-actions-pg-webapp"
REPO="sandeepdas0407/pg-webapp-test6"

echo "📋 Configuration:"
echo "Subscription ID: $SUBSCRIPTION_ID"
echo "Service Principal Name: $SP_NAME"
echo "GitHub Repository: $REPO"
echo ""

# Set the subscription
echo "🔄 Setting subscription..."
az account set --subscription $SUBSCRIPTION_ID

# Create service principal
echo "🔐 Creating service principal..."
SP_OUTPUT=$(az ad sp create-for-rbac \
  --name "$SP_NAME" \
  --role "Contributor" \
  --scopes "/subscriptions/$SUBSCRIPTION_ID" \
  --json-auth)

echo ""
echo "✅ Service Principal Created Successfully!"
echo ""

# Parse the JSON output
CLIENT_ID=$(echo $SP_OUTPUT | jq -r '.clientId')
CLIENT_SECRET=$(echo $SP_OUTPUT | jq -r '.clientSecret')
TENANT_ID=$(echo $SP_OUTPUT | jq -r '.tenantId')

echo "🔐 Generated Credentials:"
echo "CLIENT_ID: $CLIENT_ID"
echo "TENANT_ID: $TENANT_ID"
echo "CLIENT_SECRET: [HIDDEN - will be shown in commands below]"
echo ""

# Check if GitHub CLI is available
if command -v gh &> /dev/null; then
    echo "📝 Configuring GitHub Secrets automatically..."
    
    # Login to GitHub (this will prompt for authentication)
    gh auth status || gh auth login
    
    # Set secrets
    echo "$CLIENT_ID" | gh secret set AZURE_CLIENT_ID --repo $REPO
    echo "$CLIENT_SECRET" | gh secret set AZURE_CLIENT_SECRET --repo $REPO
    echo "$TENANT_ID" | gh secret set AZURE_TENANT_ID --repo $REPO
    echo "$SUBSCRIPTION_ID" | gh secret set AZURE_SUBSCRIPTION_ID --repo $REPO
    
    echo "✅ GitHub Secrets configured automatically!"
    
else
    echo "📝 Manual GitHub Secrets Configuration:"
    echo "Go to: https://github.com/$REPO/settings/secrets/actions"
    echo ""
    echo "Add these Repository Secrets:"
    echo "AZURE_CLIENT_ID: $CLIENT_ID"
    echo "AZURE_CLIENT_SECRET: $CLIENT_SECRET"
    echo "AZURE_TENANT_ID: $TENANT_ID"
    echo "AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID"
    echo ""
    echo "Or run these commands locally if you have GitHub CLI:"
    echo ""
    echo "gh secret set AZURE_CLIENT_ID --body \"$CLIENT_ID\" --repo $REPO"
    echo "gh secret set AZURE_CLIENT_SECRET --body \"$CLIENT_SECRET\" --repo $REPO"
    echo "gh secret set AZURE_TENANT_ID --body \"$TENANT_ID\" --repo $REPO"
    echo "gh secret set AZURE_SUBSCRIPTION_ID --body \"$SUBSCRIPTION_ID\" --repo $REPO"
fi

echo ""
echo "🎯 Final Steps:"
echo "1. Go to: https://github.com/$REPO/actions"
echo "2. Manually trigger the 'Test GitHub Actions Setup' workflow"
echo "3. If successful, make any code change and push to trigger deployment"
echo ""
echo "🔗 Important Links:"
echo "• Repository: https://github.com/$REPO"
echo "• GitHub Actions: https://github.com/$REPO/actions"
echo "• GitHub Secrets: https://github.com/$REPO/settings/secrets/actions"
echo "• Live Application: https://app-webapp-auvx5tx4cnram.azurewebsites.net"
echo "• Azure Portal: https://portal.azure.com"
echo ""
echo "✅ Setup Complete! Your CI/CD pipeline is now ready! 🎉"

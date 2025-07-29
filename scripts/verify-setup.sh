#!/bin/bash

# Verify GitHub Actions Setup Status
# This script checks if all components are properly configured

echo "🔍 Verifying GitHub Actions Setup Status"
echo "Repository: sandeepdas0407/pg-webapp-test6"
echo "Date: $(date)"
echo ""

REPO="sandeepdas0407/pg-webapp-test6"

echo "📋 Checking Repository Variables..."
gh variable list --repo $REPO

echo ""
echo "🔐 Checking Repository Secrets..."
SECRETS=$(gh secret list --repo $REPO)
if [ -z "$SECRETS" ]; then
    echo "❌ No secrets configured yet"
    echo ""
    echo "📝 Required Secrets:"
    echo "  - AZURE_CLIENT_ID"
    echo "  - AZURE_CLIENT_SECRET" 
    echo "  - AZURE_TENANT_ID"
    echo "  - AZURE_SUBSCRIPTION_ID"
    echo ""
    echo "🔧 To configure:"
    echo "1. Run: ./scripts/complete-azure-setup.sh in Azure Cloud Shell"
    echo "2. Or manually create service principal and add secrets"
else
    echo "✅ Secrets found:"
    echo "$SECRETS"
fi

echo ""
echo "🚀 Checking Workflows..."
gh workflow list --repo $REPO

echo ""
echo "📊 Recent Workflow Runs..."
gh run list --repo $REPO --limit 5

echo ""
echo "🔗 Quick Links:"
echo "• Repository: https://github.com/$REPO"
echo "• Actions: https://github.com/$REPO/actions"
echo "• Secrets: https://github.com/$REPO/settings/secrets/actions"
echo "• Live App: https://app-webapp-auvx5tx4cnram.azurewebsites.net"

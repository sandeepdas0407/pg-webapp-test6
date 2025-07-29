#!/bin/bash

# Quick Setup Script for GitHub Actions Azure Deployment
# This script will help you configure the necessary Azure credentials

echo "🚀 Setting up GitHub Actions for Azure Deployment"
echo "Repository: https://github.com/sandeepdas0407/pg-webapp-test6"
echo ""

echo "📋 You need to configure the following GitHub Secrets:"
echo ""
echo "1. Go to: https://github.com/sandeepdas0407/pg-webapp-test6/settings/secrets/actions"
echo ""

echo "2. Add these Repository Secrets:"
echo "   AZURE_CLIENT_ID - (from App Registration)"
echo "   AZURE_CLIENT_SECRET - (from App Registration)"  
echo "   AZURE_TENANT_ID - (from App Registration)"
echo "   AZURE_SUBSCRIPTION_ID - f07bc955-3375-4d24-9327-223f77fc24b8"
echo ""

echo "3. Add these Repository Variables (Variables tab):"
echo "   AZURE_ENV_NAME - PandG1"
echo "   AZURE_LOCATION - eastus2"
echo ""

echo "🔧 To create App Registration via Azure Portal:"
echo "1. Go to: https://portal.azure.com"
echo "2. Search for 'App registrations'"
echo "3. Click 'New registration'"
echo "4. Name: github-actions-pg-webapp"
echo "5. Click 'Register'"
echo "6. Note down Application (client) ID and Directory (tenant) ID"
echo "7. Go to 'Certificates & secrets' → 'New client secret'"
echo "8. Copy the secret value"
echo "9. Go to Subscriptions → Free Trial → Access control (IAM)"
echo "10. Add role assignment: Contributor to your app registration"
echo ""

echo "✅ Once configured, any push to main/master will trigger deployment!"
echo "🌐 Your app will be deployed to: https://app-webapp-auvx5tx4cnram.azurewebsites.net"

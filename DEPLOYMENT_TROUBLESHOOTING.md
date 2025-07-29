# GitHub Actions Deployment Troubleshooting Guide

## Fixed Issues ✅

### 1. **Authentication Problems**
- **Problem**: Mixed authentication methods causing conflicts
- **Solution**: Standardized on `AZURE_CREDENTIALS` service principal authentication
- **Fix Applied**: Updated all workflows to use consistent authentication

### 2. **AZD Authentication**
- **Problem**: `azd auth login --use-device-code=false` doesn't work in GitHub Actions
- **Solution**: Used Azure CLI authentication with `azd config set auth.useAzCliAuth true`
- **Fix Applied**: Updated azd-deploy.yml workflow

### 3. **Resource Group Issues**
- **Problem**: Hard-coded resource group name that might not exist
- **Solution**: Added resource group creation logic
- **Fix Applied**: Dynamic resource group creation in workflows

### 4. **Environment Variables**
- **Problem**: Missing or undefined environment variables
- **Solution**: Added fallback values and proper environment configuration
- **Fix Applied**: Updated azure.yaml and workflow files

## Required GitHub Secrets

You need to configure these secrets in your GitHub repository:

### Service Principal Authentication
```
AZURE_CREDENTIALS - Azure service principal credentials (JSON format)
AZURE_SUBSCRIPTION_ID - Your Azure subscription ID
```

### AZURE_CREDENTIALS Format
```json
{
  "clientId": "your-client-id",
  "clientSecret": "your-client-secret",
  "subscriptionId": "your-subscription-id",
  "tenantId": "your-tenant-id"
}
```

## How to Get Azure Credentials

### Method 1: Using Azure CLI
```bash
az ad sp create-for-rbac --name "github-actions-webapp" \
                         --role contributor \
                         --scopes /subscriptions/{subscription-id} \
                         --sdk-auth
```

### Method 2: Using Azure Portal
1. Go to Azure Active Directory > App registrations
2. Create new registration
3. Add client secret
4. Assign Contributor role to subscription
5. Format credentials as JSON

## Workflow Files

### Primary Workflow: `deploy.yml`
- **Purpose**: Main deployment workflow
- **Triggers**: Push to main/master branches
- **Features**: Build, test, deploy infrastructure, deploy app

### Secondary Workflow: `azd-deploy.yml`
- **Purpose**: Azure Developer CLI deployment
- **Triggers**: Manual only (workflow_dispatch)
- **Features**: Uses AZD for infrastructure and app deployment

### Legacy Workflow: `azure-deploy.yml`
- **Purpose**: Traditional Azure deployment
- **Status**: Still available but may have conflicts

## Verification Steps

1. **Check Secrets**: Ensure all required secrets are configured in GitHub
2. **Monitor Workflow**: Watch GitHub Actions tab for deployment progress
3. **Check Logs**: Review workflow logs for specific error messages
4. **Verify Resources**: Check Azure portal for created resources
5. **Test Application**: Verify app is accessible at the deployment URL

## Common Issues & Solutions

### Issue: "Resource group not found"
**Solution**: The workflow now creates the resource group automatically

### Issue: "Authentication failed"
**Solution**: Verify AZURE_CREDENTIALS secret is properly formatted JSON

### Issue: "Deployment conflicts"
**Solution**: Use only one workflow at a time (prefer deploy.yml)

### Issue: "App not responding"
**Solution**: Check application logs in Azure portal, verify image paths

## Next Steps

1. Monitor the current deployment in GitHub Actions
2. Check if secrets are properly configured
3. Verify the application is accessible
4. Update any remaining authentication issues

Last Updated: July 28, 2025

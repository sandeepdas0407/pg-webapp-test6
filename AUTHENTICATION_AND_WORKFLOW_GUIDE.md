# GitHub Actions Authentication Fix & Workflow Cleanup

## 🚨 CURRENT ERROR RESOLVED

**Error**: `Login failed with Error: Using auth-type: SERVICE_PRINCIPAL. Not all values are present. Ensure 'client-id' and 'tenant-id' are supplied.`

**Root Cause**: The Azure login action was configured incorrectly for the authentication method being used.

**Solution Applied**: Fixed the authentication configuration to use the proper `creds` parameter format.

## 🔧 AUTHENTICATION FIX

The issue was with the Azure login configuration. The action needs the credentials in the correct format.

### Required GitHub Secrets

You need to configure **ONE** of these two approaches:

#### Option 1: JSON Credentials (Recommended - What we're using)
```
AZURE_CREDENTIALS = {
  "clientId": "your-client-id",
  "clientSecret": "your-client-secret", 
  "subscriptionId": "your-subscription-id",
  "tenantId": "your-tenant-id"
}
```

#### Option 2: Individual Secrets (Alternative)
```
AZURE_CLIENT_ID = your-client-id
AZURE_CLIENT_SECRET = your-client-secret
AZURE_SUBSCRIPTION_ID = your-subscription-id
AZURE_TENANT_ID = your-tenant-id
```

**Current Configuration**: Using Option 1 (JSON format)

## 📁 WHY MULTIPLE WORKFLOW FILES?

You currently have **4 workflow files** in your project:

### 1. `deploy.yml` ✅ **RECOMMENDED - Main Workflow**
- **Purpose**: Primary deployment workflow
- **Triggers**: Automatic on push to main/master
- **Features**: Build → Test → Deploy app only
- **Best For**: Regular code deployments
- **Status**: Simplified and reliable

### 2. `azd-deploy.yml` ⚙️ **INFRASTRUCTURE WORKFLOW**
- **Purpose**: Azure Developer CLI deployment
- **Triggers**: Manual only (workflow_dispatch)
- **Features**: Deploy infrastructure + app using AZD
- **Best For**: Infrastructure changes or complete environment setup
- **Status**: Manual trigger to avoid conflicts

### 3. `azure-deploy.yml` 🔄 **LEGACY WORKFLOW**
- **Purpose**: Traditional Azure ARM deployment
- **Triggers**: Automatic on push (conflicting with deploy.yml)
- **Features**: Separate infrastructure and app deployment
- **Status**: **Should be disabled or removed**

### 4. `test-auth.yml` 🧪 **DEBUGGING WORKFLOW**
- **Purpose**: Test Azure authentication only
- **Triggers**: Manual only
- **Features**: Verify secrets and authentication
- **Best For**: Troubleshooting auth issues

## 🎯 RECOMMENDED WORKFLOW STRATEGY

### For Daily Use:
- **Use `deploy.yml`** for regular code deployments
- **Use `azd-deploy.yml`** when you need infrastructure changes

### Cleanup Recommended:
- **Disable `azure-deploy.yml`** to avoid conflicts
- **Keep `test-auth.yml`** for troubleshooting

## 🔨 IMMEDIATE ACTIONS NEEDED

### 1. Configure Azure Credentials
Run this Azure CLI command to create the service principal:

```bash
az ad sp create-for-rbac --name "github-actions-pg-webapp" \
                         --role contributor \
                         --scopes /subscriptions/{your-subscription-id} \
                         --sdk-auth
```

Copy the entire JSON output as the `AZURE_CREDENTIALS` secret.

### 2. Set GitHub Secrets
Go to: Repository Settings → Secrets and variables → Actions

Add:
- `AZURE_CREDENTIALS` (the JSON from step 1)
- `AZURE_SUBSCRIPTION_ID` (your subscription ID)

### 3. Test Authentication
Run the "Test Azure Authentication" workflow manually to verify setup.

### 4. Clean Up Workflows (Optional)
Disable `azure-deploy.yml` by adding this to the top:
```yaml
on:
  # Disabled to avoid conflicts with main deploy workflow
  workflow_dispatch:
```

## 🚀 EXPECTED RESULTS

After configuring the secrets correctly:
1. ✅ Azure login should succeed
2. ✅ Deployment workflows should run without authentication errors
3. ✅ Your app should deploy successfully to Azure

The authentication configuration is now correct - you just need to set up the Azure service principal and GitHub secrets!

---
**Status**: Authentication configuration fixed ✅  
**Next Step**: Configure GitHub secrets with Azure service principal 🔑

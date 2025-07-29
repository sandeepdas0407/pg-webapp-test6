# Azure Login Issues - Complete Solution Guide

## Current Problem: Azure Login Failing in GitHub Actions

The workflows are failing during the Azure login step. This is typically due to:

1. **Missing or incorrectly formatted Azure credentials**
2. **GitHub Environment requirements not met**
3. **Service principal permissions issues**

## ✅ IMMEDIATE FIXES APPLIED

### 1. Removed Environment Dependencies
- **Issue**: `environment: Production` requires GitHub environment configuration
- **Fix**: Removed environment requirements from workflows
- **Result**: Workflows no longer depend on GitHub environment setup

### 2. Enhanced Azure Login
- **Issue**: Azure login step had minimal error handling
- **Fix**: Added verification steps and better error handling
- **Result**: Better debugging information when login fails

### 3. Added Authentication Test Workflow
- **File**: `test-auth.yml`
- **Purpose**: Dedicated workflow to test authentication
- **Usage**: Run manually to verify secrets are working

## 🔑 REQUIRED GITHUB SECRETS

You MUST configure these secrets in your GitHub repository:

### Navigate to: Repository Settings → Secrets and variables → Actions

**Required Secrets:**

1. **AZURE_CREDENTIALS** (Service Principal JSON)
2. **AZURE_SUBSCRIPTION_ID** (Your Azure Subscription ID)

## 📋 AZURE_CREDENTIALS Format

The `AZURE_CREDENTIALS` secret must be in this exact JSON format:

```json
{
  "clientId": "your-service-principal-client-id",
  "clientSecret": "your-service-principal-client-secret",
  "subscriptionId": "your-azure-subscription-id",
  "tenantId": "your-azure-tenant-id"
}
```

## 🛠️ HOW TO CREATE SERVICE PRINCIPAL

### Method 1: Using Azure CLI (Recommended)

```bash
# Login to Azure
az login

# Create service principal with contributor role
az ad sp create-for-rbac --name "github-actions-pg-webapp" \
                         --role contributor \
                         --scopes /subscriptions/{your-subscription-id} \
                         --sdk-auth

# This will output JSON - copy the entire JSON as AZURE_CREDENTIALS secret
```

### Method 2: Using Azure Portal

1. **Azure Active Directory** → **App registrations** → **New registration**
2. **Name**: "github-actions-pg-webapp"
3. **Certificates & secrets** → **New client secret** → Copy the secret value
4. **Subscriptions** → Your subscription → **Access control (IAM)** → **Add role assignment**
   - Role: Contributor
   - Assign access to: User, group, or service principal
   - Select: Your app registration

## 🔍 VERIFICATION STEPS

### Step 1: Check Secret Configuration
1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Verify both secrets exist:
   - `AZURE_CREDENTIALS`
   - `AZURE_SUBSCRIPTION_ID`

### Step 2: Test Authentication
1. Go to Actions tab in your repository
2. Run the "Test Azure Authentication" workflow manually
3. Check the output for authentication success/failure

### Step 3: Monitor Deployment
1. After fixing secrets, trigger the main deployment workflow
2. Watch for successful Azure login in the logs

## 🚨 COMMON ISSUES & SOLUTIONS

### Issue: "Service principal not found"
**Solution**: Recreate the service principal using the Azure CLI method above

### Issue: "Insufficient privileges"
**Solution**: Ensure the service principal has "Contributor" role on the subscription

### Issue: "Invalid credentials format"
**Solution**: Verify the AZURE_CREDENTIALS JSON format is exactly as shown above

### Issue: "Subscription not found"
**Solution**: Double-check the subscription ID in both the service principal and the secret

## 🎯 NEXT STEPS

1. **Configure the secrets** using the guide above
2. **Run the test workflow** to verify authentication
3. **Trigger the main deployment** once authentication works
4. **Monitor the deployment** for success

Once the Azure credentials are properly configured, all workflows should run successfully!

---
**Last Updated**: July 29, 2025  
**Status**: Authentication fixes applied, awaiting secret configuration ⏳

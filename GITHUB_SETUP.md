# GitHub Repository Setup Guide

Your GitHub repository has been created successfully! 🎉

**Repository URL**: https://github.com/sandeepdas0407/pg-webapp-test6

## 🔧 Next Steps to Enable Automatic Deployment

Since Azure CLI authentication requires additional setup, I'll provide you with the exact steps to configure GitHub Actions for automatic deployment.

### Option 1: Using Azure Portal (Recommended)

1. **Create App Registration**:
   - Go to [Azure Portal](https://portal.azure.com)
   - Navigate to "Microsoft Entra ID" → "App registrations"
   - Click "New registration"
   - Name: `github-actions-pg-webapp`
   - Click "Register"

2. **Create Client Secret**:
   - In your app registration, go to "Certificates & secrets"
   - Click "New client secret"
   - Description: `github-actions-secret`
   - Expiry: 24 months
   - Copy the **secret value** (you'll need this)

3. **Get Required IDs**:
   - From your app registration overview page, copy:
     - **Application (client) ID**
     - **Directory (tenant) ID**

4. **Assign Permissions**:
   - Go to "Subscriptions" → "Free Trial"
   - Navigate to "Access control (IAM)"
   - Click "Add role assignment"
   - Role: "Contributor"
   - Assign access to: "User, group, or service principal"
   - Search for `github-actions-pg-webapp` and select it
   - Click "Review + assign"

### Configure GitHub Repository Secrets

Go to your GitHub repository: https://github.com/sandeepdas0407/pg-webapp-test6

1. Navigate to **Settings** → **Secrets and variables** → **Actions**

2. **Add Repository Secrets** (click "New repository secret"):

   | Secret Name | Value |
   |-------------|-------|
   | `AZURE_CLIENT_ID` | Application (client) ID from step 3 |
   | `AZURE_CLIENT_SECRET` | Client secret value from step 2 |
   | `AZURE_TENANT_ID` | Directory (tenant) ID from step 3 |
   | `AZURE_SUBSCRIPTION_ID` | `f07bc955-3375-4d24-9327-223f77fc24b8` |

3. **Add Repository Variables** (click "Variables" tab, then "New repository variable"):

   | Variable Name | Value |
   |---------------|-------|
   | `AZURE_ENV_NAME` | `PandG1` |
   | `AZURE_LOCATION` | `eastus2` |

### Alternative: Manual Service Principal Creation

If you prefer command line, once Azure CLI is working:

```bash
# Create service principal
az ad sp create-for-rbac \
  --name "github-actions-pg-webapp" \
  --role contributor \
  --scopes "/subscriptions/f07bc955-3375-4d24-9327-223f77fc24b8" \
  --json-auth

# This will output JSON with the credentials you need
```

### 🚀 Test the Deployment

Once you've configured the secrets and variables:

1. Go to your repository: https://github.com/sandeepdas0407/pg-webapp-test6
2. Navigate to **Actions** tab
3. You should see the workflows ready to run
4. Make a small change to any file and push to trigger deployment:

```bash
# Make a small change
echo "# Deployment test" >> README.md
git add README.md
git commit -m "Test GitHub Actions deployment"
git push
```

### 📋 Available Workflows

Your repository now has two deployment workflows:

1. **Azure Developer CLI Deploy** (`azd-deploy.yml`) - **Recommended**
   - Uses the same `azd` commands we've been using
   - Deploys both infrastructure and application
   - Automatically handles environment setup

2. **Standard Azure Deploy** (`azure-deploy.yml`) - Alternative
   - Traditional build and deploy approach
   - Separate infrastructure and application deployment jobs

### 🔍 Monitoring Deployment

- **GitHub Actions**: View deployment progress in the Actions tab
- **Azure Portal**: Monitor resources in the `rg-PandG1` resource group
- **Application URL**: https://app-webapp-auvx5tx4cnram.azurewebsites.net/

### 🆘 Troubleshooting

If deployment fails:
1. Check the Actions logs for specific error messages
2. Verify all secrets and variables are correctly set
3. Ensure the service principal has Contributor access to the subscription
4. Check that the App Registration hasn't expired

---

**Your application is now ready for continuous deployment! 🎯**

Every push to the main/master branch will automatically:
- Build your .NET application
- Deploy infrastructure changes (if any)
- Deploy the updated application to Azure
- Run with Application Insights monitoring enabled

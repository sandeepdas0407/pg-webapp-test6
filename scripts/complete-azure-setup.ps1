# Complete Azure Setup and GitHub Configuration Script
# Run this after logging into Azure CLI with: az login

param(
    [switch]$CreateServicePrincipal = $true,
    [switch]$ConfigureGitHubSecrets = $true
)

Write-Host "🚀 Complete Setup for GitHub Actions Azure Deployment" -ForegroundColor Green
Write-Host "Repository: sandeepdas0407/pg-webapp-test6" -ForegroundColor Cyan
Write-Host "Date: $(Get-Date)" -ForegroundColor Gray
Write-Host ""

# Set variables
$SUBSCRIPTION_ID = "f07bc955-3375-4d24-9327-223f77fc24b8"
$SP_NAME = "github-actions-pg-webapp"
$REPO = "sandeepdas0407/pg-webapp-test6"

Write-Host "📋 Configuration:" -ForegroundColor Yellow
Write-Host "Subscription ID: $SUBSCRIPTION_ID" -ForegroundColor White
Write-Host "Service Principal Name: $SP_NAME" -ForegroundColor White
Write-Host "GitHub Repository: $REPO" -ForegroundColor White
Write-Host ""

if ($CreateServicePrincipal) {
    try {
        Write-Host "🔄 Setting subscription..." -ForegroundColor Blue
        az account set --subscription $SUBSCRIPTION_ID
        
        Write-Host "🔐 Creating service principal..." -ForegroundColor Blue
        $SP_OUTPUT = az ad sp create-for-rbac `
            --name $SP_NAME `
            --role "Contributor" `
            --scopes "/subscriptions/$SUBSCRIPTION_ID" `
            --json-auth | ConvertFrom-Json
        
        Write-Host ""
        Write-Host "✅ Service Principal Created Successfully!" -ForegroundColor Green
        Write-Host ""
        
        $CLIENT_ID = $SP_OUTPUT.clientId
        $CLIENT_SECRET = $SP_OUTPUT.clientSecret
        $TENANT_ID = $SP_OUTPUT.tenantId
        
        Write-Host "🔐 Generated Credentials:" -ForegroundColor Yellow
        Write-Host "CLIENT_ID: $CLIENT_ID" -ForegroundColor White
        Write-Host "TENANT_ID: $TENANT_ID" -ForegroundColor White
        Write-Host "CLIENT_SECRET: [HIDDEN - will be used automatically]" -ForegroundColor Gray
        Write-Host ""
        
        if ($ConfigureGitHubSecrets) {
            Write-Host "📝 Configuring GitHub Secrets..." -ForegroundColor Blue
            
            # Set secrets using GitHub CLI
            try {
                gh secret set AZURE_CLIENT_ID --body $CLIENT_ID --repo $REPO
                gh secret set AZURE_CLIENT_SECRET --body $CLIENT_SECRET --repo $REPO  
                gh secret set AZURE_TENANT_ID --body $TENANT_ID --repo $REPO
                gh secret set AZURE_SUBSCRIPTION_ID --body $SUBSCRIPTION_ID --repo $REPO
                
                Write-Host "✅ GitHub Secrets configured automatically!" -ForegroundColor Green
            }
            catch {
                Write-Host "⚠️  GitHub CLI configuration failed. Manual setup required:" -ForegroundColor Yellow
                Write-Host "Go to: https://github.com/$REPO/settings/secrets/actions" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "Add these Repository Secrets:" -ForegroundColor Yellow
                Write-Host "AZURE_CLIENT_ID: $CLIENT_ID" -ForegroundColor White
                Write-Host "AZURE_CLIENT_SECRET: $CLIENT_SECRET" -ForegroundColor White
                Write-Host "AZURE_TENANT_ID: $TENANT_ID" -ForegroundColor White  
                Write-Host "AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID" -ForegroundColor White
            }
        }
        
    }
    catch {
        Write-Host "❌ Error creating service principal: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please ensure you're logged into Azure CLI with: az login" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host ""
Write-Host "🎯 Final Steps:" -ForegroundColor Green
Write-Host "1. Go to: https://github.com/$REPO/actions" -ForegroundColor White
Write-Host "2. Manually trigger the 'Test GitHub Actions Setup' workflow" -ForegroundColor White
Write-Host "3. If successful, make any code change and push to trigger deployment" -ForegroundColor White
Write-Host ""
Write-Host "🔗 Important Links:" -ForegroundColor Yellow
Write-Host "• Repository: https://github.com/$REPO" -ForegroundColor Cyan
Write-Host "• GitHub Actions: https://github.com/$REPO/actions" -ForegroundColor Cyan
Write-Host "• GitHub Secrets: https://github.com/$REPO/settings/secrets/actions" -ForegroundColor Cyan
Write-Host "• Live Application: https://app-webapp-auvx5tx4cnram.azurewebsites.net" -ForegroundColor Cyan
Write-Host "• Azure Portal: https://portal.azure.com" -ForegroundColor Cyan
Write-Host ""
Write-Host "✅ Setup Complete! Your CI/CD pipeline is now ready! 🎉" -ForegroundColor Green

# Open important URLs
Start-Process "https://github.com/$REPO/actions"
Start-Process "https://github.com/$REPO/settings/secrets/actions"

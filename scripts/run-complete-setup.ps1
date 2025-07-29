# Direct Azure Service Principal Creation and GitHub Secrets Setup
# This script creates the service principal and sets up GitHub secrets

$ErrorActionPreference = "Stop"

Write-Host "🚀 Creating Azure Service Principal and Setting GitHub Secrets" -ForegroundColor Green
Write-Host ""

# Configuration
$subscriptionId = "f07bc955-3375-4d24-9327-223f77fc24b8"
$spName = "github-actions-pg-webapp"
$repo = "sandeepdas0407/pg-webapp-test6"

# Try to create service principal using az CLI
Write-Host "🔐 Creating Azure Service Principal..." -ForegroundColor Blue

try {
    # Create service principal
    $spOutput = az ad sp create-for-rbac `
        --name $spName `
        --role "Contributor" `
        --scopes "/subscriptions/$subscriptionId" `
        --json-auth | ConvertFrom-Json
    
    $clientId = $spOutput.clientId
    $clientSecret = $spOutput.clientSecret
    $tenantId = $spOutput.tenantId
    
    Write-Host "✅ Service Principal created successfully!" -ForegroundColor Green
    Write-Host "Client ID: $clientId" -ForegroundColor Cyan
    Write-Host "Tenant ID: $tenantId" -ForegroundColor Cyan
    
    # Set GitHub secrets
    Write-Host ""
    Write-Host "📝 Setting GitHub Secrets..." -ForegroundColor Blue
    
    gh secret set AZURE_CLIENT_ID --body $clientId --repo $repo
    gh secret set AZURE_CLIENT_SECRET --body $clientSecret --repo $repo
    gh secret set AZURE_TENANT_ID --body $tenantId --repo $repo
    gh secret set AZURE_SUBSCRIPTION_ID --body $subscriptionId --repo $repo
    
    Write-Host "✅ All GitHub secrets configured!" -ForegroundColor Green
    
    # Verify secrets
    Write-Host ""
    Write-Host "🔍 Verifying GitHub secrets..." -ForegroundColor Blue
    gh secret list --repo $repo
    
    Write-Host ""
    Write-Host "🎉 SETUP COMPLETE! Your CI/CD pipeline is now ready!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🚀 Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Go to: https://github.com/$repo/actions" -ForegroundColor White
    Write-Host "2. Trigger the 'Test GitHub Actions Setup' workflow manually" -ForegroundColor White
    Write-Host "3. Make any code change and push to test automatic deployment" -ForegroundColor White
    
    # Open GitHub Actions page
    Start-Process "https://github.com/$repo/actions"
    
}
catch {
    Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔧 Manual Setup Required:" -ForegroundColor Yellow
    Write-Host "1. Open Azure Cloud Shell: https://shell.azure.com" -ForegroundColor Cyan
    Write-Host "2. Run: curl -s https://raw.githubusercontent.com/sandeepdas0407/pg-webapp-test6/master/scripts/complete-azure-setup.sh | bash" -ForegroundColor Cyan
    Write-Host "3. Or login to Azure CLI locally with: az login" -ForegroundColor Cyan
}

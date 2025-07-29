# Quick Setup Script for GitHub Actions Azure Deployment
# This script will help you configure the necessary Azure credentials

Write-Host "🚀 Setting up GitHub Actions for Azure Deployment" -ForegroundColor Green
Write-Host "Repository: https://github.com/sandeepdas0407/pg-webapp-test6" -ForegroundColor Cyan
Write-Host ""

Write-Host "📋 You need to configure the following GitHub Secrets:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to: https://github.com/sandeepdas0407/pg-webapp-test6/settings/secrets/actions" -ForegroundColor White
Write-Host ""

Write-Host "2. Add these Repository Secrets:" -ForegroundColor Yellow
Write-Host "   AZURE_CLIENT_ID - (from App Registration)" -ForegroundColor White
Write-Host "   AZURE_CLIENT_SECRET - (from App Registration)" -ForegroundColor White
Write-Host "   AZURE_TENANT_ID - (from App Registration)" -ForegroundColor White
Write-Host "   AZURE_SUBSCRIPTION_ID - f07bc955-3375-4d24-9327-223f77fc24b8" -ForegroundColor White
Write-Host ""

Write-Host "3. Add these Repository Variables (Variables tab):" -ForegroundColor Yellow
Write-Host "   AZURE_ENV_NAME - PandG1" -ForegroundColor White
Write-Host "   AZURE_LOCATION - eastus2" -ForegroundColor White
Write-Host ""

Write-Host "🔧 To create App Registration via Azure Portal:" -ForegroundColor Blue
Write-Host "1. Go to: https://portal.azure.com" -ForegroundColor White
Write-Host "2. Search for 'App registrations'" -ForegroundColor White
Write-Host "3. Click 'New registration'" -ForegroundColor White
Write-Host "4. Name: github-actions-pg-webapp" -ForegroundColor White
Write-Host "5. Click 'Register'" -ForegroundColor White
Write-Host "6. Note down Application (client) ID and Directory (tenant) ID" -ForegroundColor White
Write-Host "7. Go to 'Certificates & secrets' → 'New client secret'" -ForegroundColor White
Write-Host "8. Copy the secret value" -ForegroundColor White
Write-Host "9. Go to Subscriptions → Free Trial → Access control (IAM)" -ForegroundColor White
Write-Host "10. Add role assignment: Contributor to your app registration" -ForegroundColor White
Write-Host ""

Write-Host "✅ Once configured, any push to main/master will trigger deployment!" -ForegroundColor Green
Write-Host "🌐 Your app will be deployed to: https://app-webapp-auvx5tx4cnram.azurewebsites.net" -ForegroundColor Cyan

# Open the GitHub secrets page
Start-Process "https://github.com/sandeepdas0407/pg-webapp-test6/settings/secrets/actions"

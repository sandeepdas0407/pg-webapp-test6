# PowerShell script to create Azure Service Principal for GitHub Actions
# Run this script after creating your GitHub repository

Write-Host "Creating Azure Service Principal for GitHub Actions..." -ForegroundColor Green

# Set variables
$SUBSCRIPTION_ID = "f07bc955-3375-4d24-9327-223f77fc24b8"
$SP_NAME = "github-actions-pg-webapp"
$RESOURCE_GROUP = "rg-PandG1"

Write-Host "Subscription ID: $SUBSCRIPTION_ID" -ForegroundColor Yellow
Write-Host "Service Principal Name: $SP_NAME" -ForegroundColor Yellow

# Create service principal
Write-Host "Creating service principal..." -ForegroundColor Blue
$SP_OUTPUT = az ad sp create-for-rbac `
  --name $SP_NAME `
  --role contributor `
  --scopes "/subscriptions/$SUBSCRIPTION_ID" `
  --sdk-auth

Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host "Service Principal Created Successfully!" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Copy the following JSON and add it as AZURE_CREDENTIALS secret in GitHub:" -ForegroundColor Yellow
Write-Host ""
Write-Host $SP_OUTPUT -ForegroundColor Cyan
Write-Host ""

# Parse JSON for individual values
$SP_JSON = $SP_OUTPUT | ConvertFrom-Json
$CLIENT_ID = $SP_JSON.clientId
$CLIENT_SECRET = $SP_JSON.clientSecret
$TENANT_ID = $SP_JSON.tenantId

Write-Host "==============================================" -ForegroundColor Green
Write-Host "Individual values for GitHub Secrets:" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host "AZURE_CREDENTIALS: (Use the entire JSON above)" -ForegroundColor White
Write-Host "AZURE_SUBSCRIPTION_ID: $SUBSCRIPTION_ID" -ForegroundColor White
Write-Host "AZURE_CLIENT_ID: $CLIENT_ID" -ForegroundColor White
Write-Host "AZURE_CLIENT_SECRET: $CLIENT_SECRET" -ForegroundColor White
Write-Host "AZURE_TENANT_ID: $TENANT_ID" -ForegroundColor White
Write-Host "AZURE_ENV_NAME: PandG1" -ForegroundColor White
Write-Host "AZURE_LOCATION: eastus2" -ForegroundColor White
Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host "Next Steps:" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host "1. Go to your GitHub repository" -ForegroundColor Yellow
Write-Host "2. Navigate to Settings → Secrets and variables → Actions" -ForegroundColor Yellow
Write-Host "3. Add each of the above values as repository secrets" -ForegroundColor Yellow
Write-Host "4. Push your code to trigger the GitHub Actions workflow" -ForegroundColor Yellow
Write-Host ""

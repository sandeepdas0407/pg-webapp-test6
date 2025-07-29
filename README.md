# P&G Web Application - Test6

A .NET 9.0 ASP.NET Core web application deployed to Azure App Service with Application Insights integration.

## Features

- .NET 9.0 ASP.NET Core MVC application
- Azure App Service hosting
- Application Insights telemetry and monitoring
- Infrastructure as Code using Azure Bicep
- CI/CD deployment using GitHub Actions
- Managed Identity for secure Azure resource access

## Local Development

### Prerequisites

- .NET 9.0 SDK
- Azure CLI
- Azure Developer CLI (azd)

### Running Locally

1. Clone the repository
2. Navigate to the WebApplication1 folder
3. Run the application:

```bash
dotnet run
```

The application will be available at `https://localhost:5265`

## Azure Deployment

This project uses Azure Developer CLI (azd) for deployment.

### Initial Deployment

1. Install Azure Developer CLI
2. Login to Azure: `az login`
3. Deploy: `azd up`

### Current Deployment

- **Application URL**: https://app-webapp-auvx5tx4cnram.azurewebsites.net/
- **Resource Group**: rg-PandG1
- **Subscription**: Free Trial (f07bc955-3375-4d24-9327-223f77fc24b8)

## GitHub Actions CI/CD

This repository includes two GitHub Actions workflows:

### 1. Azure Developer CLI Deploy (`azd-deploy.yml`)
Uses Azure Developer CLI for complete infrastructure and application deployment.

### 2. Standard Azure Deploy (`azure-deploy.yml`)
Traditional build and deploy workflow using Azure Web Apps Deploy action.

## Required GitHub Secrets

To enable GitHub Actions deployment, configure these secrets in your repository:

### For both workflows:
- `AZURE_CREDENTIALS` - Azure service principal credentials in JSON format
- `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID

### For AZD workflow (recommended):
- `AZURE_CLIENT_ID` - Service principal client ID
- `AZURE_CLIENT_SECRET` - Service principal client secret
- `AZURE_TENANT_ID` - Azure tenant ID
- `AZURE_ENV_NAME` - Azure environment name (currently: PandG1)
- `AZURE_LOCATION` - Azure region (currently: eastus2)

## Setting up GitHub Secrets

### 1. Create a Service Principal

```bash
az ad sp create-for-rbac --name "github-actions-pg-webapp" --role contributor --scopes /subscriptions/f07bc955-3375-4d24-9327-223f77fc24b8 --sdk-auth
```

### 2. Configure Repository Secrets

1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Add the following secrets:

- **AZURE_CREDENTIALS**: The entire JSON output from the service principal creation
- **AZURE_SUBSCRIPTION_ID**: `f07bc955-3375-4d24-9327-223f77fc24b8`
- **AZURE_CLIENT_ID**: The `clientId` from the service principal JSON
- **AZURE_CLIENT_SECRET**: The `clientSecret` from the service principal JSON
- **AZURE_TENANT_ID**: The `tenantId` from the service principal JSON
- **AZURE_ENV_NAME**: `PandG1`
- **AZURE_LOCATION**: `eastus2`

## Project Structure

```
├── .github/workflows/          # GitHub Actions workflows
├── infra/                      # Azure Bicep infrastructure files
│   ├── main.bicep             # Main infrastructure template
│   └── main.parameters.json   # Infrastructure parameters
├── WebApplication1/           # .NET application
│   ├── Controllers/           # MVC controllers
│   ├── Models/               # Data models
│   ├── Views/                # Razor views
│   └── wwwroot/              # Static files
├── azure.yaml                # Azure Developer CLI configuration
└── README.md                 # This file
```

## Architecture

- **App Service**: Windows-based hosting with .NET 9.0 runtime
- **Application Insights**: Application performance monitoring
- **Log Analytics**: Centralized logging workspace
- **Managed Identity**: Secure authentication to Azure services

## Monitoring

Application Insights is configured to collect:
- Request telemetry
- Dependency tracking
- Exception logging
- Performance counters
- Custom events and metrics

Access monitoring data through the Azure portal Application Insights resource.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Create a pull request

The GitHub Actions workflows will automatically build and test your changes.

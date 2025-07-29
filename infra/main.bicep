// Infrastructure as Code for WebApplication1 App Service deployment
targetScope = 'resourceGroup'

@description('Environment name')
param environmentName string

@description('Location for all resources')
param location string = resourceGroup().location

// Generate unique resource token
var resourceToken = uniqueString(subscription().id, resourceGroup().id, location, environmentName)

// User-assigned managed identity for secure access
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'mi-webapp-${resourceToken}'
  location: location
  tags: {
    'azd-env-name': environmentName
  }
}

// Log Analytics workspace for monitoring
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: 'log-webapp-${resourceToken}'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
  tags: {
    'azd-env-name': environmentName
  }
}

// Application Insights for application monitoring
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-webapp-${resourceToken}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
  tags: {
    'azd-env-name': environmentName
  }
}

// App Service Plan for hosting the web application
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'asp-webapp-${resourceToken}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'app'
  properties: {
    reserved: false // Windows App Service Plan
    perSiteScaling: false
  }
  tags: {
    'azd-env-name': environmentName
  }
}

// App Service for the web application
resource appService 'Microsoft.Web/sites@2024-04-01' = {
  name: 'app-webapp-${resourceToken}'
  location: location
  kind: 'app'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      windowsFxVersion: 'DOTNETCORE|9.0'
      netFrameworkVersion: 'v9.0'
      alwaysOn: true
      cors: {
        allowedOrigins: ['*']
        supportCredentials: false
      }
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
    }
  }
  tags: {
    'azd-env-name': environmentName
    'azd-service-name': 'WebApplication1'
  }
}

// Diagnostic settings for App Service
resource appServiceDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'default'
  scope: appService
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'AppServiceHTTPLogs'
        enabled: true
      }
      {
        category: 'AppServiceConsoleLogs'
        enabled: true
      }
      {
        category: 'AppServiceAppLogs'
        enabled: true
      }
      {
        category: 'AppServiceAuditLogs'
        enabled: true
      }
      {
        category: 'AppServiceIPSecAuditLogs'
        enabled: true
      }
      {
        category: 'AppServicePlatformLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

// Output values for reference
output RESOURCE_GROUP_ID string = resourceGroup().id
output APP_SERVICE_NAME string = appService.name
output APP_SERVICE_URL string = 'https://${appService.properties.defaultHostName}'
output APPLICATION_INSIGHTS_CONNECTION_STRING string = applicationInsights.properties.ConnectionString
output MANAGED_IDENTITY_CLIENT_ID string = managedIdentity.properties.clientId
output MANAGED_IDENTITY_PRINCIPAL_ID string = managedIdentity.properties.principalId

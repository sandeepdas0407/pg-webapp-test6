// Complete Azure Service Principal Setup for GitHub Actions
// This script provides all the commands and values needed

console.log("🚀 Complete GitHub Actions Setup for Azure Deployment");
console.log("Repository: https://github.com/sandeepdas0407/pg-webapp-test6");
console.log("");

console.log("📋 Step 1: Create Azure Service Principal");
console.log("Run this command in Azure Cloud Shell or Azure CLI:");
console.log("");
console.log("az ad sp create-for-rbac \\");
console.log("  --name 'github-actions-pg-webapp' \\");
console.log("  --role 'Contributor' \\");
console.log("  --scopes '/subscriptions/f07bc955-3375-4d24-9327-223f77fc24b8' \\");
console.log("  --json-auth");
console.log("");

console.log("📝 Step 2: Configure GitHub Secrets");
console.log("Go to: https://github.com/sandeepdas0407/pg-webapp-test6/settings/secrets/actions");
console.log("");

console.log("Add these Repository Secrets:");
const secrets = {
    "AZURE_CLIENT_ID": "From service principal output: clientId",
    "AZURE_CLIENT_SECRET": "From service principal output: clientSecret", 
    "AZURE_TENANT_ID": "From service principal output: tenantId",
    "AZURE_SUBSCRIPTION_ID": "f07bc955-3375-4d24-9327-223f77fc24b8"
};

Object.entries(secrets).forEach(([key, value]) => {
    console.log(`  ${key}: ${value}`);
});

console.log("");
console.log("Add these Repository Variables (Variables tab):");
const variables = {
    "AZURE_ENV_NAME": "PandG1",
    "AZURE_LOCATION": "eastus2"
};

Object.entries(variables).forEach(([key, value]) => {
    console.log(`  ${key}: ${value}`);
});

console.log("");
console.log("🔗 Quick Links:");
console.log("• Azure Portal: https://portal.azure.com");
console.log("• GitHub Secrets: https://github.com/sandeepdas0407/pg-webapp-test6/settings/secrets/actions");
console.log("• Repository: https://github.com/sandeepdas0407/pg-webapp-test6");
console.log("• Live App: https://app-webapp-auvx5tx4cnram.azurewebsites.net");
console.log("");
console.log("✅ Once configured, GitHub Actions will automatically deploy on every push!");

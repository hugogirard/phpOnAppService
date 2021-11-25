@description('The location of the resources')
param location string

@description('Specifies the name of the File Share. File share names must be between 3 and 63 characters in length and use numbers, lower-case letters and dash (-) only.')
@minLength(3)
@maxLength(63)
param fileShareName string

var suffix = uniqueString(resourceGroup().id)
var webAppName = 'app-php-${suffix}'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'plan-php-${suffix}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {    
    serverFarmId: appServicePlan.id
    clientAffinityEnabled: false
    siteConfig: {      
      linuxFxVersion: 'PHP|8.0'
      alwaysOn: true
    }
  }
}

resource sa 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'str${suffix}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${sa.name}/default/${fileShareName}'
}

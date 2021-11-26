param location string
param suffix string

var webAppPhpName = 'app-php-${suffix}'
var webappNodeName = 'app-node-${suffix}'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: 'plan-php-${suffix}'
  kind: 'linux'
  location: location
  properties: {    
    reserved: true
  }
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
  }
}

resource webAppPhp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppPhpName
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


resource webAppNode 'Microsoft.Web/sites@2021-02-01' = {
  name: webappNodeName
  location: location
  properties: {    
    serverFarmId: appServicePlan.id
    clientAffinityEnabled: false
    siteConfig: {      
      linuxFxVersion: 'NODE|14-lts'
      alwaysOn: true
    }
  }
}


output webPhpName string = webAppPhp.name
output webNodeName string = webAppNode.name

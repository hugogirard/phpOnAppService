@description('The location of the resources')
param location string

@description('Specifies the name of the File Share. File share names must be between 3 and 63 characters in length and use numbers, lower-case letters and dash (-) only.')
@minLength(3)
@maxLength(63)
param fileShareName string

var suffix = uniqueString(resourceGroup().id)


module str 'modules/storage/storage.bicep' = {
  name: 'str'
  params: {
    fileShareName: fileShareName
    locations: location
    suffix: suffix
  }
}

module web 'modules/web/web.bicep' = {
  name: 'web'
  params: {
    location: location
    suffix: suffix
  }
}

output webPhpName string = web.outputs.webPhpName
output webNodeName string = web.outputs.webNodeName
output storageName string = str.outputs.storageName
output storageKey string = str.outputs.accessKey

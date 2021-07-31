$spCredentials = Get-Credential
$spApplicationId = $env:ARM_CLIENT_ID
$spPassword = ConvertTo-SecureString $env:ARM_CLIENT_SECRET -AsPlainText -Force
$spCredentials = New-Object System.Management.Automation.PSCredential($spApplicationId , $spPassword)
Connect-AzAccount -ServicePrincipal -Credential $spCredentials -Tenant $env:ARM_TENANT_ID  -Subscription $env:ARM_SUBSCRIPTION_ID
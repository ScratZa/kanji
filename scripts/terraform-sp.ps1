
# Create Service principle with contributor access to subscription in order to enable terraform login
$sub_id = "sub_Id"
$sub_name = "TerraformPrinciple"
$tenant_id = "Tenant_Id"
$sp = New-AzADServicePrincipal -Scope /subscriptions/$sub_id -DisplayName $sub_name

# Get Secret Value
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sp.Secret)
$UnsecureSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$UnsecureSecret
$env:SP = $UnsecureSecret
# - Set environment variables for these values for now
# Get PS Credential 
$spCredentials = Get-Credential
$spApplicationId = $sp.ApplicationId
$spPassword = ConvertTo-SecureString $env:SP -AsPlainText -Force
$spCredentials = New-Object System.Management.Automation.PSCredential($spApplicationId , $spPassword)
Connect-AzAccount -ServicePrincipal -Credential $spCredentials -Tenant $tenant_id 

$env:ARM_CLIENT_ID = $sp.ApplicationId
$env:ARM_SUBSCRIPTION_ID = $sub_id
$env:ARM_TENANT_ID = $tenant_id
$env:ARM_CLIENT_SECRET =$UnsecureSecret

Get-ChildItem env:ARM_*

az loginc
#### Parameters

$keyvaultname = "triton-kv"
$location = "eastasia"
$keyvaultrg = "triton-kv-sg"
$sshkeysecret = "triton-ssh-public-key"
$spnclientid = "1e42b294-077c-4bd5-93f3-5b7866308609"
$clientidkvsecretname = "triton-service-principal-client-id"
$spnclientsecret = "EZh8Q~wmcSPH7JlqzhI5J~ozSavBPkuPxbdW7cXj"
$spnkvsecretname = "triton-sp-client-secret-vaule"
$spobjectID = "1e42b294-077c-4bd5-93f3-5b7866308609"
$userobjectid = "1e42b294-077c-4bd5-93f3-5b7866308609"


#### Create Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location

New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list

#### create an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f ~/.ssh/id_rsa_terraform


#### Add SSH Key in Azure Key vault secret

$pubkey = cat ~/.ssh/id_rsa_terraform.pub

$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


#### Store service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientid -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


#### Store service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


#### Provide Keyvault secret access to SPN using Keyvault access policy

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spobjectID -PermissionsToSecrets Get,Set

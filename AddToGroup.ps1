$Password = ( ConvertTo-SecureString "Disturbed1" -AsPlainText -Force )
$Credential = New-Object System.Management.Automation.PSCredential ("Administrator", $Password)

$UserName = Read-Host -Prompt 'Enter Username'
$GroupName = Read-Host -Prompt 'Enter Group'

Invoke-Command -ComputerName SERVER2022 -ArgumentList $UserName, $GroupName -Credential ($Credential) -ScriptBlock { Add-ADGroupMember -Identity $args[1] -Members $args[0] }

Write-Host "The User $UserName has been accepted into group $GroupName"
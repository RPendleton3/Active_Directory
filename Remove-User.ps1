$Password = ( ConvertTo-SecureString "P@ssw0rd01" -AsPlainText -Force )
$Credential = New-Object System.Management.Automation.PSCredential ("Administrator", $Password)

$UserName = Read-Host -Prompt 'Enter Username'

Invoke-Command -ComputerName SERVER2022 -ArgumentList $UserName -Credential ($Credential) -ScriptBlock { Remove-ADUser $args[0]}

Write-Host "The user $UserName has been removed"
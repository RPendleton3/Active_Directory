$Password = ( ConvertTo-SecureString "P@ssw0rd01" -AsPlainText -Force )
$Credential = New-Object System.Management.Automation.PSCredential ("Administrator", $Password)



$UserName = Read-Host -Prompt 'Enter Username' 
$GivenName = Read-Host -Prompt 'Enter First Name'
$SurName = Read-Host -Prompt 'Enter Last Name'
$GroupName = Read-Host -Prompt 'Enter Group, if none type none'

Invoke-Command -ComputerName SERVER2022 -ArgumentList $UserName, $GivenName, $SurName -Credential ($Credential) -ScriptBlock { New-ADUser $args[0] -GivenName $args[1] -SurName $args[2] -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd01" -Force) -ChangePasswordAtLogon $true -Enabled $true }

if ($GroupName -notmatch 'none')
{
	Invoke-Command -ComputerName SERVER2022 -ArgumentList $UserName, $GroupName -Credential ($Credential) -ScriptBlock { Add-ADGroupMember -identity $args[1] -Members $args[0] }
}


Write-Host "An Account has been created for $GivenName $SurName with a base password of P@ssw0rd01"
Write-Host "Remind user that on first sign in they will be prompt for a new password"
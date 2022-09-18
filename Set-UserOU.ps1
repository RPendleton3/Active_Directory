$Password = ( ConvertTo-SecureString "Disturbed1" -AsPlainText -Force )
$Credential = New-Object System.Management.Automation.PSCredential ("Administrator", $Password)

$UserName = Read-Host -Prompt 'Enter Username' 
Write-Host "Enter the Name of the Organizational Unit for the User"
Write-Host "Domain Controllers"
Write-Host "Administrator"
Write-Host "Management"
Write-Host "Or Type End"

$OUobject = Read-Host -Prompt 'Enter Organizational Unit'

if ($OUobject -eq 'Domain Controllers')
{
	#Write-Host "Domain Controllers"
	Move-ADObject -Identity "CN=$UserName,CN=Users,DC=XYZ,DC=local" -TargetPath "OU=Domain Controllers,DC=XYZ,DC=local"
}
elseif ($OUobject -eq 'Administrator')
{
	#Write-Host "Administrator"
	Move-ADObject -Identity "CN=$UserName,CN=Users,DC=XYZ,DC=local" -TargetPath "OU=Administrator,OU=Domain Controllers,DC=XYZ,DC=local"
}
elseif($OUobject -eq 'Management')
{
	#Write-Host "Management"
	Move-ADObject -Identity "CN=$UserName,CN=Users,DC=XYZ,DC=local" -TargetPath "OU=Management,OU=Domain Controllers,DC=XYZ,DC=local"
}
else
{
	Write-Host "Script End"
}



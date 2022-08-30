# Active_Directory
Active Directory Lab information

# 00 - Setup Virtual Enviroments

    1. Installed Virtualbox VM for Windows Server 2022 Core Evaluation
    2. Installed Virtualbox VM for Windows 11 Professional
    

# 01 - Setting Up Domain Controller

    1. Used sconfig to:
      1.1 Change the hostname to SERVER2022
      1.2 Change the ip address to Static
      1.3 Change the dns server to own ip address
    2. Install the Active Directory Windows Feature
      2.1 Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
      2.2 Import-Module ADDSDeployment
      2.3 Install-ADDSForest
    3. Used sconfig again to reset dns server to own ip address
    
    
# 02 - Joining a Workstation to the Domain

    1. Change workstation dns server to Domain ip
      1.1 Get-DNSClientServerAddress
      1.2 Set-DNSClientServerAddress -InterfaceIndex 13 -ServerAddress 10.0.0.38
    2. Join Domain
      2.1 Add-Computer -Domainname XYZ.local -Credential XYZ\Administrator -Force -Restart
      
      
# 03 - Creating Domain User

    1. Check to see list of current users attached to Domain
      1.1 Get-ADUser -Filter *
    2. Create Domain user account (John Smith)
      2.1 New-ADUser John -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd01" -Force) -ChangePasswordAtLogon $true -Enabled $true
    3. Verify user account exists and is functional
      3.1 Get-ADUser -Identity John
    4. Set additional user information
      4.1 Set-ADUser John -Surname Smith
      4.2 Set-ADUser John -GivenName John
    5. Create second Domain user account (Jane Doe)
      5.1 New-ADUser Jane -Surname Doe -GivenName Jane -AccountPassword (ConvertTo-SecureString -AsPlaintext "P@ssw0rd01" -Force) -ChangePasswordAtLogon $true -Enabled           $true
      5.2 Get-ADUser Jane
      
      
# 04 - Working with Groups

    1. Check list of current groups
      1.1 get-ADGroup -Filter * | Format-Table DistinguishedName
    2. On Workstation, determine which group has admin privileges
      2.1 Get-LocalGroupMember -Group "Administrators"
    3. After determining Domain Admins group, Set user Jane to Admin
      3.1 Add-ADGroupMember -Identity "Domain Admins" -Members Jane
      
      
# 05 - Additional tasks with Users

    1. Simulate user John forgetting password
      1.1 Set-ADAccountPassword -Identity John -NewPassword (ConvertTo-SecureString -AsPlaintext "P@ssw0rd01" -Force) -Reset
      1.2 Set ADUser John -ChangePasswordAtLogon $true
    2. Disable user account
      2.1 Set-ADUser John -Enabled $true
    3. Remove user account
      3.1 Remove-ADUser John
      

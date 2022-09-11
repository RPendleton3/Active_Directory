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
      1.1 Get-ADGroup -Filter * | Format-Table DistinguishedName
    2. On Workstation, determine which group has admin privileges
      2.1 Get-LocalGroupMember -Group "Administrators"
    3. After determining Domain Admins group, Set user Jane to Admin
      3.1 Add-ADGroupMember -Identity "Domain Admins" -Members Jane
      
      
# 05 - Additional tasks with Users

    1. Simulate user John forgetting password
      1.1 Set-ADAccountPassword -Identity John -NewPassword (ConvertTo-SecureString -AsPlaintext "P@ssw0rd01" -Force) -Reset
      1.2 Set ADUser John -ChangePasswordAtLogon $true
    2. Disable user account
      2.1 Set-ADUser John -Enabled $false
    3. Remove user account
      3.1 Remove-ADUser John
      

# 06 - Enabling and Creating remote session
    
    1. Enable Remote Session on Server
      1.1 Enable-PSRemoting
    2. Enable Service on Workstation and Configure Trusted Hosts
      2.1 Start-Service WinRM
      2.2 Get-Item wsman:\localhost\Client\TrustedHosts
      2.3 Set-Item wsman:\localhost\Client\TrustedHosts -value 10.0.0.38
    3. Create Session on Workstation and Verify connection
      3.1 New-PSSession -ComputerName 10.0.0.38 -Credential (Get-Credential)
      3.2 Enter-PSSession 1
      
      
# 07 - Working with Powershell script files for Automation
    1. Downloaded Notepad++ on Workstation
    2. Change Execution policy for Deployment
      2.1 Set-ExecutionPolicy RemoteSigned
    3. Created file RemoteConnect.ps1 to automate Connection to Server
    4. Launch file
      4.1 C:\Users\Admin\RemoteConnect.ps1
    5. Alternate command if powershell is in current directory
      5.1 .\RemoteConnect.ps1
    6. Created file Add-User.ps1 to automate the creation of new Domain Users
      6.1 Script takes user input for Username, GivenName and Surname
      6.2 Script has pre-defined variables for remote connection to the server
      6.3 Script creates a base password and forces new user to reset upon first logon
      6.4 Next Revision will add more information including groups
    7. Created file Reset-Password.ps1 to automate the reset of lost passwords
    8. Created file Remove-User.ps1 to automate removal of domain users
    
# 08 - Working with Groups and Sharefiles
    1. Using Remove-User.ps1, remove all users except Administrator
    2. Using Add-User.ps1, create six new domain users
      2.1 RPendleton - Robert Pendleton
      2.2 JSmith - John Smith
      2.3 JDoe - Jane Doe
      2.4 MJackson - Michael Jackson
      2.5 JWalton - Joe Walton
      2.6 EJohnson - Erin Johnson
    3. Created AddToGroup.ps1 script to remotely add users to groups
    4. Placed all Users into Employee group and RPendleton into Domain Admins group
    5. Created file for network storage
      5.1 mkdir C:\NetworkStorage
      5.2 mkdir C:\NetworkStorage\RPendleton
    6. Setup share specifically for admin RPendleton
      6.1 New-SmbShare -Name "RPendletonShare" -Path "C:\NetworkStorage\RPendleton" -FullAccess "RPendleton"
      6.2 icacls "C:\NetworkStorage\RPendleton" /grant "RPendleton:(OI)(CI)(F)"
    7. Create new group for filesharing for base level staff
      7.1 New-ADGroup Staff -GroupScope Global -GroupCategory Security
      7.2 Add-ADGroupMember -Identity Staff -Members RPendleton, JSmith, JDoe, MJackson, JWalton, EJohnson
      7.3 New-SmbShare -Name "StaffShare" -Path "C:\NetworkStorage\Employee -FullAccess "Staff"
      7.4 icacls "C:\NetworkStorage\Employee" /grant "Staff:(OI)(CI)(F)"
    8. Grant access to "StaffShare" for Domain Admins
      8.1 Grant-SmbShareAccess -Name "StaffShare" -AccountName "Domain Admins" -AccessRight Full
    9. Changed Add-User script to include ability to add group upon user creation 
    
# 09 - Working with setting up and configuring Group Policys
    1. Install Group Policy Management Console
      1.1 Install-WindowsFeature GPMC -IncludeManagementTools
    

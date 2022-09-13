# Active_Directory_GUI_Lab
Active Directory Lab information

# 00 - Setup Virtual Enviroments
    
    1. Installed Virtualbox VM for Windows Server 2022 Evaluation Full
    2. Installed Virtualbox VM for Windows 11 Professional
    
# 01 - Setting Up Domain Controller

    1. Install the Active Directory Windows Feature
      1.1 Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
      1.2 Import-Module ADDSDeployment
      1.3 Install-ADDSForest
    2. Changed DNS address to localhost
      2.1 Get-DNSClientServerAddress
      2.2 Set-DNSClientServerAddress -InterfaceIndex 13 -ServerAddress 10.0.0.56
    3. Install Group Policy Management Console
      3.1 Install-WindowsFeature GPMC -IncludeManagementTools

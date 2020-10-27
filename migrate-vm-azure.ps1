<#
  Migrate a Virtual Machine from on-premises to the cloud with PowerShell
  Author: Michael Washam
  Website: http://michaelwasham.com
  Twitter: MWashamMS
#>

# Retrieve with Get-AzureSubscription 
$subscriptionName = '[MY SUBSCRIPTION]'  

# Retreive with Get-AzureStorageAccount 
$storageAccountName = '[MY STORAGE ACCOUNT]'   

# Specify the storage account location to store the newly created VHDs 
Set-AzureSubscription -SubscriptionName $subscriptionName -CurrentStorageAccount $storageAccountName 
 
# Select the correct subscription (allows multiple subscription support) 
Select-AzureSubscription -SubscriptionName $subscriptionName 

# Retreive with Get-AzureLocation 
$location = 'West US' 

# ExtraSmall, Small, Medium, Large, ExtraLarge
$instanceSize = 'Medium' 

# Has to be a unique name. Verify with Test-AzureService
$serviceName = '[UNIQUE SERVICE NAME]' 

# Server Name
$vmname1 = '[MY VM NAME]'

# Source VHDs
$sourceosvhd = 'C:\MyVHDs\AppServer1OSDisk.vhd'
$sourcedatavhd = 'C:\MyVHDs\AppServer1DataDisk.vhd'

# Target Upload Location 
$destosvhd = 'http://' + $storageAccountName + '.blob.core.windows.net/uploads/AppServer1OSDisk.vhd'
$destdatavhd = 'http://' + $storageAccountName + '.blob.core.windows.net/uploads/AppServer1DataDisk.vhd'

Add-AzureVhd -LocalFilePath $sourceosvhd -Destination $destosvhd 
Add-AzureVhd -LocalFilePath $sourcedatavhd -Destination $destdatavhd

Add-AzureDisk -OS Windows -MediaLocation $destosvhd -DiskName 'AppServer1OSDisk'
Add-AzureDisk -MediaLocation $destdatavhd -DiskName 'AppServer1DataDisk'

$migratedVM = New-AzureVMConfig -Name $vmname1 -DiskName 'AppServer1OSDisk' -InstanceSize 'Medium' |
					Add-AzureDataDisk -Import -DiskName 'AppServer1DataDisk' -LUN 0 |
					Add-AzureEndpoint -Name 'Remote Desktop' -LocalPort 3389 -Protocol tcp 
					
New-AzureVM -ServiceName $serviceName -Location $location -VMs $migratedVM 					
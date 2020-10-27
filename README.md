Migrate a Virtual Machine to Windows Azure using PowerShell
===========================================================

            

 


This example uploads two VHD files to a Windows Azure Storage Account using the Add-AzureVHD cmdlet. Once uploaded it then creates the disk references (one for the OS Disk and the second for the Data Disk). Once the disk references are created it then creates
 a new Windows Azure Virtual Machine using the uploaded disk and adds an RDP endpoint for remote access.


Cmdlets used:


  *  Set-AzureSubscription 
  *  Select-AzureSubscription 
  *  Add-AzureVHD 
  *  Add-AzureDisk 
  *  New-AzureVMConfig 
  *  New-AzureVM 

 


 

 

 


        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.

# escape=`

FROM microsoft/aspnet:4.7.1-windowsservercore-1709

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN New-Item -Path 'C:\Sitecore' -Type Directory | Out-Null;

# About the folder 'C:\Sitecore\Website'
#    It cannot be created to prevent failure while moving it from its original location to the "C:\Sitecore\" folder
#    It is possible to create an IIS site pointing to its path without actually existing.
#    In any case, it must be left empty to support Volumes during Development
	
RUN Import-Module WebAdministration; `
    Set-ItemProperty -Path 'IIS:\Sites\Default Web Site' -Name 'physicalPath' -Value 'C:\Sitecore\Website'; `
    Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool' -Name 'enable32BitAppOnWin64' -Value 'True'; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';

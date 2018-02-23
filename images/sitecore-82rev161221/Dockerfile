# escape=`
FROM microsoft/aspnet:4.7.1-windowsservercore-1709_KB4048955

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN New-Item -Path 'C:\Sitecore' -Type Directory | Out-Null;

ADD Sitecore /Sitecore

RUN Import-Module WebAdministration; `
    Set-ItemProperty -Path 'IIS:\Sites\Default Web Site' -Name 'physicalPath' -Value 'C:\Sitecore\Website'; `
    Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool' -Name 'enable32BitAppOnWin64' -Value 'True'; `
    Set-Itemproperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    setx /M PATH $($env:PATH + ';C:\Sitecore\Scripts'); `
    Add-LocalGroupMember -Group 'Administrators' -Member 'IIS AppPool\DefaultAppPool';

# escape=`

FROM sitecore-8-base

ARG source

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

COPY *.zip .

RUN Expand-Archive -Path 'C:\Sitecore*rev*.zip' -DestinationPath 'C:'; `
    Remove-Item 'C:\Sitecore*.zip' -Force; `
    Move-Item -Path 'C:\Sitecore *rev*\Website' -Destination 'C:\Sitecore'; `
    Remove-Item -Path 'C:\Sitecore *rev*' -Recurse -Force;

COPY DataFolder.config \Sitecore\Website\App_Config\Include

# Add license file at the end to avoid changing license to invalidate previous steps in the Docker cache
COPY license.xml \Sitecore\Data

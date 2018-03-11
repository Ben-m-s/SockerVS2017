# escape=`

FROM sitecore:8.2.161221

ARG source

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /Sitecore/Website
COPY ${source:-obj/Docker/publish} .

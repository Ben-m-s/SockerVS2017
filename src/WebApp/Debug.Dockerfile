# escape=`

FROM sitecore-8-base
ARG source
WORKDIR /Sitecore/Website
COPY ${source:-obj/Docker/publish} .

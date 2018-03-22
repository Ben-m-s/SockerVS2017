$ErrorActionPreference = "STOP"

docker build -t sitecore-8-base .\images\sitecore-8-base
docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221

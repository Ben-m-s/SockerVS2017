# Socker = Sitecore :heart: Docker (now with Visual Studio 2017)

>This is the continuation of [https://github.com/pbering/Socker](https://github.com/pbering/Socker) where the new Docker integration in Visual Studio 2017 is used instead.

It is now possible to run Sitecore completely in Docker natively, you don't have to mess around with databases, IIS or anything, you don't even have to have SQL Server or IIS installed on your machine.

This repository shows how a solution could be wired up for development with the following features:

- Databases is persisted between restarts
- The "Data" folder is mounted with volume supporting persistance for all its content, including logs, serialization, Lucene indexes, packages, ...
- The "Website" folder is mounted as volume while debugging and stored in the container with the Release configuration.

and also the Visual Studio 2017, out-of-the-box docker features like:

- Remote debugging, auto attaching to running containers with F5
- Different contaner configurations for Debug and Release
- Build, re-build, clear builds/stops/starts compose services (containers)
- **New in Visual Studio 2017 15.5**: By default, Visual Studio will automatically pull, build, and run the necessary container images in the background when you open a project that has Docker support. You can disable this via the Automatically start containers in background setting in Visual Studio.

## Prerequisites

- Windows 10 Fall Creators Update
- Docker for Windows
- Visual Studio 2017 15.5 or later

## Preparations

>NOTE: Base images are build and consumed locally in this example, but in a real life scenario you would also push to an remote private repository like
hub.docker.com, quay.io or an internal one, so that images can be shared within your organization.
Unfortunately it has to be **private** repositories due to Sitecore licensing terms so we can't share images in the community.

### Using Sitecore 8.2 rev. 161221

1. Clone [this repository](https://github.com/Ben-m-s/SockerVS2017.git) into a folder such as “C:\Docker\SockerVS2017” (next steps will asume this folder has been used):
1. Copy "**Sitecore 8.2 rev. 161221.zip**" into “C:\Docker\SockerVS2017\\**images\sitecore-82rev161221**“
1. Copy "**license.xml**" into "C:\Docker\SockerVS2017\\**storage\Data**“
1. Copy the database files (*.mdf and *.ldf) from "**Sitecore 8.2 rev. 161221.zip**" into "C:\Docker\SockerVS2017\\**storage\Databases**“
1. Copy The "Website" folder files from "**Sitecore 8.2 rev. 161221.zip**" into "C:\Docker\SockerVS2017\\**storage\Website**“
1. Open VS2017 as Administrator
1. Open the solution “C:\Docker\SockerVS2017\\**Socker.sln**”
1. Open a PowerShell console as Administrator.
1. Build base images by running the folliwing PowerShell script:
    ```text
    .\Build.ps1
    ```
1. Copy file “C:\Docker\SockerVS2017\src\Website\Properties\PublishProfiles\\**Debug Website.pubxml.example**” as “**Debug Website.pubxml**”
1. Edit the Publication settings "**Debug Website**" for the project “WebApp”. Set the Target Location to “C:\Docker\SockerVS2017\\**storage\website**”
1. Build the solution.
1. Publish the WebApp project to the local folder "C:\Docker\SockerVS2017\\**storage\Website**“
1. Make sure the project “**docker-compose**” is set as StartUp project
1. Run the containers with “**Debug**” configuration. The browser will open with Sitecore’s home page.
1. Copy the container’s IP in the “c:\Windows\System32\drivers\etc\\**hosts**” file with the URL: **socker.dev.local**
1. With VS2017, edit the properties of the TDS project “**TDSMaster**”.
   1. Select tab “**Build**”
   1. Check the checkbox “**Edit user specific configuration (.user file)**”
   1. Set the following values in the text boxes:
      1. Sitecore Web Url: “http://socker.dev.local”
      1. Sitecore Deploy Folder: "C:\Docker\SockerVS2017\storage\Website“
   1. Check the checkbox “**Install Sitecore Connector**”. A guid should appear in the “Sitecore Access Guid” field
   1. Click the “**Test**” button to confirm the connection works
   1. Save the project.
1. Deploy the TDS project “**TDSMaster**”
1. Browse to “http://socker.dev.local/sitecore/shell”
1. Login with “admin” and “b”
1. Browse to “**/sitecore/content/Home**”. Confirm there is a child page deployed by TDS.


## Daily usage

1. Open solution...
1. Make sure the "docker-compose" project is your startup project
1. CTRL+F5 to run or set breakpoint and F5, Visual Studio will open your default browser automatically when the containers are ready
1. To continuously update changes from your web project output to the running container, publish the WebApp project to the folder **"/storage/Website"**. Changes will be picked up by Sitecore immediately as if it was a local IIS.

To stop everything again just hit "Build -> Clear".

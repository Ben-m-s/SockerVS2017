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

1. Copy **Sitecore 8.2 rev. 161221.zip** into **"/images/sitecore-82rev161221"**
1. Copy **license.xml** into **"/images/sitecore-82rev161221/"**
1. Copy database files from **Sitecore 8.2 rev. 161221.zip** into **"/storage/Databases"**
1. Copy website files from **Sitecore 8.2 rev. 161221.zip** into **"/storage/Website"**
1. Publish the WebApp project to the local folder **"/storage/Website"**
1. Build base images by running the folliwing PowerShell script:

    ```text
    .\Build.ps1
    ```


## Daily usage

1. Open solution...
1. Make sure the "docker-compose" project is your startup project
1. CTRL+F5 to run or set breakpoint and F5, Visual Studio will open your default browser automatically when the containers are ready
1. To continuously update changes from your web project output to the running container, publish the WebApp project to the folder **"/storage/Website"**. Changes will be picked up by Sitecore immediately as if it was a local IIS.

To stop everything again just hit "Build -> Clear".

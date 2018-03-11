# Make sure the license.xml file is in the following two required locations
# Copy the file to one location from the other. The file will need to be manually copied into one of the locations

$Path1 = ".\images\sitecore-82rev161221\license.xml"
$Path2 = ".\storage\Data\license.xml"

$Source = $Path1
$Dest = $Path2
if ([System.IO.File]::Exists($Source)){
  $Exclude = Get-ChildItem -recurse $Dest
  Get-ChildItem $Source | Copy-Item -Destination $Dest -Verbose -Exclude $Exclude
}
else {
  $Source = $Path2
  $Dest = $Path1
  if ([System.IO.File]::Exists($Source)){
    $Exclude = Get-ChildItem -recurse $Dest
    Get-ChildItem $Source | Copy-Item -Destination $Dest -Verbose -Exclude $Exclude
  }

}


# -----------------------------------------------------------------------------

$ErrorActionPreference = "STOP"

docker build -t sitecore-8-base .\images\sitecore-8-base
docker build -t sitecore:8.2.161221 .\images\sitecore-82rev161221

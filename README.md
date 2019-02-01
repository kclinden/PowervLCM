# Welcome to PowervLCM
PowervLCM is a PowerShell module built on top of the services exposed by the vRealize Automation 7 REST API.

Note: this module is not in any way developed or supported by anyone officially affiliated with VMware

## Compatibility

### vRealize Lifecycle Manager

||
| --- |
|2.0|



### PowerShell Editions

|Edition|Version|
| --- | --- |
|Desktop|5.1|
|Core|6.0.0-rc**|

To get up and running with PowerShell Core follow the instructions for your operating system [here](https://github.com/PowerShell/PowerShell/blob/master/README.md#get-powershell).

## Download

PowerShell v5.1 & v6 users: You grab the latest version of the module from the PowerShell Gallery by running the following command:

```
Install-Module -Name PowervLCM -Scope CurrentUser
```

## Quick Start

Once you have installed and imported PowervLCM, use Connect-vLCMServer to connect to your vLCM instance:

```PowerShell
Connect-vLCMServer -Server vLCM.corp.local -Credential (Get-Credential)
```

If your instance has a self signed certificate you must use the **IgnoreCertRequirements** switch:

```PowerShell
Connect-vLCMServer -Server vLCM.corp.local -Credential (Get-Credential) -IgnoreCertRequirements
```

## Running Locally
When developing, use the provided build script and import the module that is inside the Release directory.

You **do not** have to manually edit src\PowervLCM.psd1 when adding new functions

```PowerShell
# --- Run the build script
.\tools\build.ps1

# --- Import release module
Import-Module .\Release\PowervLCM\PowervLCM.psd1 -Force
```
The default build will run some quick tests to catch any errors before you push your changes.

## Documentation

Documentation for each command can be viewed with Get-Help, e.g.:

```
Get-Help Get-vLCMContent
```

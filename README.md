# PowerLCM
PowerLCM is a PowerShell module built on top of the services exposed by the vRealize Suite Lifecycle Manager 2.0 REST API

Note: This module is not officially developed or supported by VMware.

## Compatability
||
| --- | --- |
|1.x*|2.0|

* Support for version 1.x is not validated.

## Quick Start
Download the contents and import the psd1 module file.

```PowerShell
Import-Module -Path /path/to/file/PowerLCM.psd1
```

Connect to the LifeCycle Manager Server
```PowerShell
Connect-vLCMServer -Server lcm.domain.local -Credential (get-credential)
```

Invoke a LCM REST API to get all datacenters
```PowerShell
Invoke-vLCMRestMethod -Method GET -URI "/lcm/api/v1/view/datacenter"
```

Invoke a LCM REST API to get a specific datacenter
```PowerShell
$datacenters = Invoke-vLCMRestMethod -Method GET -URI "/lcm/api/v1/view/datacenter"
$datacenter = $datacenters[0]
Invoke-vLCMRestMethod -Method GET -URI "/lcm/api/v1/view/datacenter/?datacenterId=$($datacenter.id)"
```

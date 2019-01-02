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

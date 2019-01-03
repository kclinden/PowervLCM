function Get-vLCMDatacenter {
<#
    .SYNOPSIS
    Get dacenter(s) from vRealize Lifecycle Manager

    .DESCRIPTION
    Get all datacenters or a single datacenter by ID.

    .PARAMETER Id
    The id of the Datacenter

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject
    System.Object[]

    .EXAMPLE
    Get-vLCMDatacenter -Id 6da4b2a20c6b127557662cd1c8ff8

    .EXAMPLE
    Get-vLCMDatacenter

#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject', 'System.Object[]')]

    Param (

    [parameter(Mandatory=$true,ParameterSetName="ById")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Id,

    )

    try {

        switch ($PsCmdlet.ParameterSetName) {

            'ById' {

                foreach ($DatacenterId in $Id) {

                    $URI = "/lcm/api/v1/view/datacenter?datacenterId=$($DatacenterId)"

                    Write-Verbose -Message "Preparing GET to $($URI)"

                    $Response = Invoke-vLCMRestMethod -Method GET -URI "$($URI)"

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.Count -eq 0) {

                        throw "Could not find Datacenter $($DatacenterId)"

                    }

                    [pscustomobject] @{

                        datacenterName = $Response.DatacenterName
                        vCenters = $Response.vCenters
                        city = $Response.city
                        latitude = $Response.latitude
                        longitude = $Response.longitude

                    }

                }

                break

            }

            'Standard' {

                $URI = "/lcm/api/v1/view/datacenter"

                # --- Make the first request to determine the size of the request
                $Response = Invoke-vLCMRestMethod -Method GET -URI $URI

                # --- Initialise an empty array
                $ResponseObject = @()

                    Write-Verbose -Message "Response contains $($Response.Count) records"

                    foreach ($Datacenter in $Response) {
                        Write-Verbose -Message "Creating object for datacenter $Datacenter.Name"
                        $Object = [pscustomobject] @{

                          Name = $Datacenter.Name
                          ID = $Datacenter.Id

                        }

                        $ResponseObject += $Object

                    }

                # --- Return Datacenters
                $ResponseObject

                break

            }

        }

    }
    catch [Exception]{

        throw

    }

}

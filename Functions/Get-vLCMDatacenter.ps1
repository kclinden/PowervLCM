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
[CmdletBinding(DefaultParameterSetName="List")][OutputType('System.Management.Automation.PSObject', 'System.Object[]')]

    Param (

    [parameter(Mandatory=$true,ParameterSetName="ById")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Id

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
                        #vCenters = $Response.vCenters
                        city = $Response.city
                        latitude = $Response.latitude
                        longitude = $Response.longitude

                    }

                }

                break

            }

            'List' {

                $allURI = "/lcm/api/v1/view/datacenter"
                $detailURI = "/lcm/api/v1/view/datacenter?datacenterId=$($Datacenter.id)"

                # --- Make the first request to get all datacenter IDs
                $Response = Invoke-vLCMRestMethod -Method GET -URI $allURI

                # --- Initialise an empty array
                $ResponseObject = @()

                    Write-Verbose -Message "Response contains $($Response.Count) datacemter records"

                    foreach ($Datacenter in $Response) {
                        #Get the detailed view of each datacenter
                        $DetailResponse = Invoke-vLCMRestMethod -Method GET -URI $detailURI

                        $Object = [pscustomobject] @{

                          datacenterName = $DetailResponse.DatacenterName
                          #vCenters = $DetailResponse.vCenters
                          city = $DetailResponse.city
                          latitude = $DetailResponse.latitude
                          longitude = $DetailResponse.longitude

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

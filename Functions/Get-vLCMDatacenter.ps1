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

    .EXAMPLE
    Get-vLCMDatacenter -Id 6da4b2a20c6b127557662cd1c8ff8

    .EXAMPLE
    Get-vLCMDatacenter

#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject', 'System.Object[]')]

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

                        DatacenterName = $Response.DatacenterName
                        ID = $DatacenterId
                        City = $Response.city
                        Latitude = $Response.latitude
                        Longitude = $Response.longitude

                    }

                }

                break

            }

            'Standard' {
                #URL for getting all datacenter list
                $allURI = "/lcm/api/v1/view/datacenter"

                # --- Make the first request to get all datacenter IDs
                $Response = Invoke-vLCMRestMethod -Method GET -URI $allURI
                Write-Verbose -Message "Response contains $($Response.Count) datacemter records"

                # --- Initialise an empty array
                $ResponseObject = @()
                    #Loop over each datacenter in the list and get detailed view to create new object
                    foreach ($Datacenter in $Response) {
                        #Get the detailed view of each datacenter
                        $detailURI = "/lcm/api/v1/view/datacenter?datacenterId=$($Datacenter.id)"
                        Write-Verbose -Message "Getting datacenter details for $Datacenter.name via $($detailURI)"
                        $DetailResponse = Invoke-vLCMRestMethod -Method GET -URI $detailURI

                        $Object = [pscustomobject] @{

                          DatacenterName = $DetailResponse.DatacenterName
                          ID = $Datacenter.id #ID only exists on list view, so it must be retrieved from $datacenter instead of $detailresponse
                          City = $DetailResponse.city
                          Latitude = $DetailResponse.latitude
                          Longitude = $DetailResponse.longitude

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

function Get-vLCMDatacenter {
<#
    .SYNOPSIS
    Get a Datacenter

    .DESCRIPTION
    Get a Datacenter

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

    [parameter(Mandatory=$false,ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [Int]$Limit = "100",

    [parameter(Mandatory=$false,ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [Int]$Page = "1"

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

                # if (!$PSBoundParameters.ContainsKey("Page")){
                #
                #     # --- Get every page back
                #     $TotalPages = $Response.metadata.totalPages.ToInt32($null)
                #
                # }
                # else {
                #
                #     # --- Set TotalPages to 1
                #     $TotalPages = 1
                #
                # }

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

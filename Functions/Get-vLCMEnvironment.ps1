function Get-vLCMEnvironment {
<#
    .SYNOPSIS
    Get environment(s) from vRealize Lifecycle Manager

    .DESCRIPTION
    Get all Environments or a single Environment by ID.

    .PARAMETER Id
    The id of the Environment

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-vLCMEnvironment -Id 6da4b2a20c6b127557662cd1c8ff8

    .EXAMPLE
    Get-vLCMEnvironment

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

                foreach ($EnvironmentId in $Id) {

                    $URI = "/lcm/api/v1/view/Environment?EnvironmentId=$($EnvironmentId)"

                    Write-Verbose -Message "Preparing GET to $($URI)"

                    $Response = Invoke-vLCMRestMethod -Method GET -URI "$($URI)"

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.Count -eq 0) {

                        throw "Could not find Environment $($EnvironmentId)"

                    }

                    [pscustomobject] @{

                        EnvironmentName = $Response.name
                        ID = $EnvironmentId
                        Products = $Response.Products
                        Properties = $Response.Properties

                    }

                }

                break

            }

            'Standard' {
                #URL for getting all Environment list
                $allURI = "/lcm/api/v1/view/Environment"

                # --- Make the first request to get all Environment IDs
                $Response = Invoke-vLCMRestMethod -Method GET -URI $allURI
                Write-Verbose -Message "Response contains $($Response.Count) Environment records"

                # --- Initialise an empty array
                $ResponseObject = @()
                    #Loop over each Environment in the list and get detailed view to create new object
                    foreach ($Environment in $Response) {
                        #Get the detailed view of each Environment
                        $detailURI = "/lcm/api/v1/view/Environment?EnvironmentId=$($Environment.id)"
                        Write-Verbose -Message "Getting Environment details for $Environment.name via $($detailURI)"
                        $DetailResponse = Invoke-vLCMRestMethod -Method GET -URI $detailURI

                        $Object = [pscustomobject] @{

                          EnvironmentName = $DetailResponse.name
                          ID = $Environment.id #ID only exists on list view, so it must be retrieved from $Environment instead of $detailresponse
                          Products = $DetailResponse.products
                          Properties = $DetailResponse.properties

                        }

                        $ResponseObject += $Object

                    }

                # --- Return Environments
                $ResponseObject

                break

            }

        }

    }
    catch [Exception]{

        throw

    }

}

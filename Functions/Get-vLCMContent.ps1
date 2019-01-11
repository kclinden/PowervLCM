function Get-vLCMContent {
<#
    .SYNOPSIS
    Get content from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Get all content or a single content by ID.

    .PARAMETER Id
    The id of the Content

    .INPUTSf
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get contnt by content id
    Get-vLCMContent -Id 6da4b2a20c6b127557662cd1c8ff8

    .EXAMPLE
    Get all content 
    Get-vLCMContent

    .EXAMPLE
    Get

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

                foreach ($ContentId in $Id) {

                    $URI = "/lcm/api/v1/view/Content?ContentId=$($ContentId)"

                    Write-Verbose -Message "Preparing GET to $($URI)"

                    $Response = Invoke-vLCMRestMethod -Method GET -URI "$($URI)"

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.Count -eq 0) {

                        throw "Could not find Content $($ContentId)"

                    }

                    [pscustomobject] @{

                        ContentName = $Response.ContentName
                        ID = $ContentId
                        City = $Response.city
                        Latitude = $Response.latitude
                        Longitude = $Response.longitude

                    }

                }

                break

            }

            'Standard' {
                #URL for getting all Content list
                $allURI = "/lcm/api/v1/view/Content"

                # --- Make the first request to get all Content IDs
                $Response = Invoke-vLCMRestMethod -Method GET -URI $allURI
                Write-Verbose -Message "Response contains $($Response.Count) datacemter records"

                # --- Initialise an empty array
                $ResponseObject = @()
                    #Loop over each Content in the list and get detailed view to create new object
                    foreach ($Content in $Response) {
                        #Get the detailed view of each Content
                        $detailURI = "/lcm/api/v1/view/Content?ContentId=$($Content.id)"
                        Write-Verbose -Message "Getting Content details for $Content.name via $($detailURI)"
                        $DetailResponse = Invoke-vLCMRestMethod -Method GET -URI $detailURI

                        $Object = [pscustomobject] @{

                          ContentName = $DetailResponse.ContentName
                          ID = $Content.id #ID only exists on list view, so it must be retrieved from $Content instead of $detailresponse
                          City = $DetailResponse.city
                          Latitude = $DetailResponse.latitude
                          Longitude = $DetailResponse.longitude

                        }

                        $ResponseObject += $Object

                    }

                # --- Return Contents
                $ResponseObject

                break

            }

        }

    }
    catch [Exception]{

        throw

    }

}

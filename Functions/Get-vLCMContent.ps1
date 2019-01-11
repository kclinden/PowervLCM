function Get-vLCMContent {
<#
    .SYNOPSIS
    Get content from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Get all content or a single content by ID.

    .PARAMETER Id
    The id of the Content

    .PARAMETER Type
    The content type to

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get contnt by content id
    Get-vLCMContent -Id 4e87ae12-75c8-4a8d-83ab-f02d30543a08

    .EXAMPLE
    Get all content and display in a table format
    Get-vLCMContent | ft

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

                    $URI = "/cms/api/v1/content/$($ContentId)"

                    Write-Verbose -Message "Preparing GET to $($URI)"

                    $Response = Invoke-vLCMRestMethod -Method GET -URI "$($URI)"

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.Count -eq 0) {

                        throw "Could not find Content $($ContentId)"

                    }

                    [pscustomobject] @{

                      ContentName = $DetailResponse.name
                      UniqueId = $DetailResponse.uniqueId
                      ID = $detailURI.split('/')[5]
                      Type = $DetailResponse.packageType
                      RequestedBy = $DetailResponse.requestedBy
                      Tags = $DetailResponse.tags
                      Path = $DetailResponse.id
                      LatestVersion = $DetailResponse.LatestVersion
                      ReleaseableVersion = $DetailResponse.releasableVersion

                    }

                }

                break

            }

            'Standard' {
                #URL for getting all Content list
                $allURI = "/cms/api/v1/content?expands=true" # change expands to parameter after testing

                # --- Make the first request to get all Content IDs
                $Response = Invoke-vLCMRestMethod -Method GET -URI $allURI
                Write-Verbose -Message "Response contains $($Response.Count) content records"

                # --- Initialise an empty array
                $ResponseObject = @()
                    #Loop over each Content in the list and get detailed view to create new object
                    foreach ($detailURI in $Response.sortedDocuments.id) {
                        #Get the detailed view of each Content
                        Write-Verbose -Message "Getting Content details for $Content.name via $($detailURI)"
                        $DetailResponse = Invoke-vLCMRestMethod -Method GET -URI $detailURI

                        $Object = [pscustomobject] @{

                          ContentName = $DetailResponse.name
                          UniqueId = $DetailResponse.uniqueId
                          ID = $detailURI.split('/')[5]
                          Type = $DetailResponse.packageType
                          RequestedBy = $DetailResponse.requestedBy
                          Tags = $DetailResponse.tags
                          Path = $DetailResponse.id
                          LatestVersion = $DetailResponse.LatestVersion
                          ReleaseableVersion = $DetailResponse.releasableVersion

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

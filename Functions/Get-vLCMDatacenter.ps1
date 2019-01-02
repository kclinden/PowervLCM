function Get-vLCMDatacenter {
<#
    .SYNOPSIS
    Get a Datacenter

    .DESCRIPTION
    Get a Datacenter

    .PARAMETER Id
    The id of the Datacenter

    .PARAMETER Name
    The name of the Datacenter

    .PARAMETER Limit
    The number of entries returned per page from the API. This has a default value of 100.

    .PARAMETER Page
    The page of response to return. All pages are retuend by default

    .INPUTS
    System.String
    System.Int

    .OUTPUTS
    System.Management.Automation.PSObject
    System.Object[]

    .EXAMPLE
    Get-vLCMDatacenter -Id 6da4b2a20c6b127557662cd1c8ff8

    .EXAMPLE
    Get-vLCMDatacenter -Name Datacenter1

    .EXAMPLE
    Get-vLCMDatacenter

#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject', 'System.Object[]')]

    Param (

    [parameter(Mandatory=$true,ParameterSetName="ById")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Id,

    [parameter(Mandatory=$true,ParameterSetName="ByName")]
    [ValidateNotNullOrEmpty()]
    [String[]]$Name,

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

            'ByName' {

                foreach ($DatacenterName in $Name) {

                    $URI = "/Datacenter-service/api/Datacenters?`$filter=name%20eq%20'$($DatacenterName)'"

                    Write-Verbose -Message "Preparing GET to $($URI)"

                    $Response = Invoke-vLCMRestMethod -Method GET -URI "$($URI)"

                    Write-Verbose -Message "SUCCESS"

                    if ($Response.content.Count -eq 0) {

                        throw "Could not find Datacenter $($DatacenterName)"

                    }

                    [pscustomobject] @{

                        CreatedDate = $Response.content.createdDate
                        LastUpdated = $Response.content.lastUpdated
                        Version = $Response.content.version
                        Id = $Response.content.id
                        Name = $Response.content.name
                        DatacenterTypeId = $Response.content.DatacenterTypeId
                        TenantId = $Response.content.tenantId
                        SubTenantId = $Response.content.subtenantId
                        Enabled = $Response.content.enabled
                        Priority = $Response.content.Priority
                        DatacenterPolicyId = $Response.content.DatacenterPolicyId
                        AlertPolicy = $Response.content.alertPolicy
                        ExtensionData = $Response.content.extensionData

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

                while ($true){

                    #Write-Verbose -Message "Getting response for page $($Page) of $($Response.metadata.totalPages)"

                    #$PagedUri = "$($URI)&page=$($Page)&`$orderby=name%20asc"

                    #Write-Verbose -Message "GET : $($PagedUri)"

                    #$Response = Invoke-vLCMRestMethod -Method GET -URI $PagedUri

                    Write-Verbose -Message "Response contains $($Response.content.Count) records"

                    foreach ($Datacenter in $Response.content) {

                        $Object = [pscustomobject] @{

                          datacenterName = $Response.DatacenterName
                          vCenters = $Response.vCenters
                          city = $Response.city
                          latitude = $Response.latitude
                          longitude = $Response.longitude

                        }

                        $ResponseObject += $Object

                    }

                    # --- Break loop
                    #if ($Page -ge $TotalPages) {

                    #    break

                    #}

                    # --- Increment the current page by 1
                    #$Page++

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

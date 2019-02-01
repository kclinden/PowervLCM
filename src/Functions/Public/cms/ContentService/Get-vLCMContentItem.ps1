function Get-vLCMContentItem {
<#
    .SYNOPSIS
    Get content item from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Get all content or a single content by ID.

    .PARAMETER Id
    The id of the Content

    .PARAMETER PackageType
    The content type to get

    .PARAMETER Type
    The content type to filter

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

#>
[OutputType('System.Management.Automation.PSObject')]

    Param (

      [Parameter(Mandatory=$false)]
      [ValidateSet("Automation-CompositeBlueprint","Automation-ComponentProfile","Automation-PropertyDefinition","Automation-PropertyGroup","Automation-ResourceAction","Automation-Software","Automation-Subscription","Automation-XaaSBlueprint")]
      [String]$PackageType

    )

    begin{
      #Initialize
      Write-Verbose -Message "Initializing..."

      #Create PSObject for Output
      function StandardOutput ($contentItem){

        [pscustomobject]@{

          Name          =   $contentItem.name
          UniqueID      =   $contentItem.UniqueID
          Id            =   $contentItem.id
          PackageType   =   $contentItem.PackageType
          Releasable    =   $contentItem.releasable
          RequestedBy   =   $contentItem.requestedBy
          LatestVersion =   $contentItem.latestVersion
          Tags          =   $contentItem.tags

        }
      }
    }

    process{
        try {

            #URL for getting all Content list
            $contentUrl = "/cms/api/v1/content?expands=true" # change expands to parameter after testing

            # --- Make the first request to get all Content IDs
            $Response = Invoke-vLCMRestMethod -Method GET -URI $contentUrl
            Write-Verbose -Message "Response contains $($Response.Count) content records"

            # --- Initialise an empty array
            $ResponseObject = @()
                #Loop over each Content in the list and get detailed view to create new object
                foreach ($item in $Response.sortedDocuments) {

                    $ResponseObject += StandardOutput($item)

                }

            # --- Return Contents
            return $ResponseObject
            break

        }
        catch [Exception]{
            throw
        }
      }
      end{

      }


}

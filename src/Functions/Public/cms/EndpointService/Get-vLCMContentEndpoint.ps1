function Get-vLCMContentEndpoint {
<#
    .SYNOPSIS
    Get content endpoints from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Get all content endpoints or a single content by ID.

    .PARAMETER Category
    The content endpoint category type to filter

    .PARAMETER Limit
    Limit the number of objects returned. Default = 100

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get contnt by content id
    Get-vLCMContentEndpoint -Category SourceControl

    .EXAMPLE
    Get all content and display in a table format
    Get-vLCMContentEndpoint | ft

#>
[OutputType('System.Management.Automation.PSObject')]

    Param (

      [Parameter(Mandatory=$false)]
      [ValidateSet("Orchestration","Automation","SourceControl","Operations")]
      [String]$Category,

      [parameter(Mandatory=$false,ValueFromPipeline=$false)]
      [ValidateNotNullOrEmpty()]
      [String]$Limit = "100"

    )

    begin{
      #Initialize
      Write-Verbose -Message "Initializing..."

      #Create PSObject for Output
      function StandardOutput ($contentItem){

        [pscustomobject]@{

          Name          =   $contentItem.name
          Category      =   $contentItem.category
          Capture       =   $contentItem.supportCapture
          Test          =   $contentItem.supportTest
          Release       =   $contentItem.supportRelease
          Id            =   $contentItem.id
          Tags          =   $contentItem.tags

        }
      }
    }

    process{
        try {

            if($PSBoundParameters.ContainsKey('Category')){
                #URL for getting all Content Endpoints list by category
                $contentUrl = "/cms/api/v1/endpoints?expands&limit=$($Limit)"
            }
            else {
                #URL for getting all Content Endpoints list
                $contentUrl = "/cms/api/v1/endpoints?expands&limit=$($Limit)"
            }

            # --- Make the first request to get all Content IDs
            $Response = Invoke-vLCMRestMethod -Method GET -URI $contentUrl
            Write-Verbose -Message "Response contains $($Response.count) content endpoint records"

            # --- Initialise an empty array
            $ResponseObject = @()
                #Loop over each Content Endpoint in the list and get detailed view to create new object
                foreach ($item in $Response.sortedDocuments) {

                    $ResponseObject += StandardOutput($item)

                }

            # --- Return Contents
            $ResponseObject
            break

        }
        catch [Exception]{
            throw
        }
      }
      end{

      }


}

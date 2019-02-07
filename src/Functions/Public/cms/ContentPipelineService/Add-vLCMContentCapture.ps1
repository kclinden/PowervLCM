function Add-vLCMContentCapture {
<#
    .SYNOPSIS
    Get content item from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Get all content or a single content by ID.

    .PARAMETER ContentName
    The content item name

    .PARAMETER ContentType
    The type of content that is being captured

    .PARAMETER CaptureEndpoint
    Content endpoint to capture the updated content item from

    .PARAMETER Tags
    Comma seperated list of tags to add to the content

    .PARAMETER IncludeDependencies
    Include dependencies of of content - Boolean

    .PARAMETER Releaseable
    Whether to mark the content as production ready or not - Boolean

    .PARAMETER Comments
    Comments for content capture

    .INPUTS
    System.String
    System.Management.Automation.PSObject

    .OUTPUTS
    System.String

    .EXAMPLE
    Get-vLCMContentItem -Id fb9c1c95-04ac-47db-a3fe-e55ad2833f74  | Add-vLCMContentCapture -CaptureEndpoint vra01.domain.local-Tenant -Tags "IaaS, CentOS" -IncludeDependencies: $false -Releaseable: $true -Comments "Comments here"

    .EXAMPLE
    Add-vLCMContentCapture -ContentItem $contentItem -CaptureEndpoint vra01.domain.local-Tenant -Tags "IaaS","CentOS" -IncludeDependencies: $false -Releaseable: $true -Comments "Comments here"

#>
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact="Low")][OutputType('System.Management.Automation.PSObject')]

    Param (

      [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
      [Alias("Name")]
      [ValidateNotNullOrEmpty()]
      [String]$ContentName,

      [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
      [Alias("PackageType")]
      [ValidateNotNullOrEmpty()]
      [String]$ContentType,

      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [String]$CaptureEndpoint,

      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [String]$Tags,

      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [Boolean]$IncludeDependencies,

      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [Boolean]$Releaseable,

      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [String]$Comments
    )

    begin{
      #Initialize
      Write-Verbose -Message "Initializing..."

    }

    process{
        try {

$TagsAsJson = $($Tags) | ConvertTo-Json

$Template = @"
        {
            "comments": "$($Comments)",
            "uniqueId": null,
            "releasable": "$($Releaseable)",
            "capture": true,
            "test": null,
            "release": null,
            "enableUnitTests": null,
            "includeDependencies": "$($IncludeDependencies)",
            "stopTestDeploymentOnFirstFailure": null,
            "stopReleaseDeploymentOnFirstFailure": null,
            "stopDeploymentOnFirstFailure": null,
            "stopUnitTestsOnFirstFailure": null,
            "deployTestContent": null,
            "unitTestConfig": null,
            "contentName": "$($ContentName)",
            "contentEndpointName": "$($ContentEndpointName)",
            "testContentEndpoints": [],
            "packageType": [],
            "releaseContentEndpoints": [],
            "contentType": "$($ContentType)",
            "unitTestContentEndpointLink": null,
            "deployContent": null,
            "packageVersionLink": null,
            "releaseComments": null,
            "formValid": true,
            "deployIncludeDependencies": null,
            "testIncludeDependencies": null,
            "releaseLatest": null,
            "latestContent": null,
            "vROPackageName": null,
            "vROSharedPackageVersionLink": null,
            "tags": $($TagsAsJson),
            "captureByFolder": false,
            "packageVersionLinks": [],
            "deployFiles": [],
            "deployAllFiles": true
          }
"@
            if ($PSCmdlet.ShouldProcess($endpoint)) {
              #URL for getting all Content Pipeline Service Commands
              $contentUrl = "/cms/api/v1/pipelines/capture" # change expands to parameter after testing

              # --- Make the first request to get all Content IDs
              $Response = Invoke-vLCMRestMethod -Method POST -URI $contentUrl -Body $Template
              Write-Verbose -Message "Response contains $($Response.Count) content records"

              # --- Return Contents
              return $Reponse
              break
            }

        }
        catch [Exception]{
            throw
        }
      }
      end{

      }


}

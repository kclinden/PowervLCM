function Add-vLCMContent {
<#
    .SYNOPSIS
    Captures a new content item via the vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Captures a new content item via the vRealize Lifecycle Manager content management service

    .PARAMETER ContentEndpointName
    The name of the content endpoint in vRealize Lifecycle Manager (Example: vra.domain.local-Tenant)

    .PARAMETER ContentType
    Content Type that is being captured (Example: Automation-CompositeBlueprint)

    .PARAMETER ContentName
    Name of the content that is being captured (Example: Apache Web Server)

    .PARAMETER UniqueID
    Unique ID of the content that is being captured (Example: ApacheWebServer)

    .PARAMETER Comments
    Comments to add to the capture

    .PARAMETER Releaseable
    Mark the content as release able - Boolean

    .PARAMETER IncludeDependencies
    Include the dependencies of the content that is captured - Boolean

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Add-vLCMContent -Id 4e87ae12-75c8-4a8d-83ab-f02d30543a08

    .EXAMPLE
    Add-vLCMContent | ft

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="Low")][OutputType('System.Management.Automation.PSObject')]

    Param (

      [Parameter(Mandatory=$false)]
      [ValidateSet("Automation-CompositeBlueprint","Automation-ComponentProfile","Automation-PropertyDefinition","Automation-PropertyGroup","Automation-ResourceAction","Automation-Software","Automation-Subscription","Automation-XaaSBlueprint")]
      [String]$ContentType

    )

    begin{

      #Initialize
      Write-Verbose -Message "Initializing..."

    }

    process{

        try {
          if($PSCmdlet.ShouldProcess($newContent.name)){ #this needs to be modified

            #URL for getting all Content list
            $contentUrl = "/cms/api/v1/content?expands=true" # change expands to parameter after testing

            # --- Make the first request to get all Content IDs
            $Response = Invoke-vLCMRestMethod -Method POST -URI $contentUrl
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

        }

        catch [Exception]{

            throw

        }

      }

      end{

        #Finish
        Write-Verbose -Message "Finishing..."

      }


}

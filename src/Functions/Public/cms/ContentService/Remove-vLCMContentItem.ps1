function Remove-vLCMContentItem {
    <#
    .SYNOPSIS
    Remove a content item from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Remove a content item from vRealize Lifecycle Manager content management service

    .PARAMETER ContentId
    The content item to remove

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Remove-vLCMContentItem -ContentId a50d0992-bf12-424e-8a4c-a502dba422bb

    .EXAMPLE
    Get-vLCMContentItem | Remove-vLCMContentItem

#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    Param (

        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("id")]
        [ValidateNotNullOrEmpty()]
        [String[]]$ContentId

    )

    begin {
        #Initialize
        Write-Verbose -Message "Initializing..."

    }

    process {
        #Process
        Write-Verbose -Message "Processing..."

        try {

            foreach ($item in $ContentId) {

                if ($PSCmdlet.ShouldProcess($item)) {
                    $URI = "/cms/api/v1/content/$($item)"

                    #Invoke REST request
                    #This method will return an async request for the deletion operation.
                    #In a future version it would be better to capture that and track the status until it is "COMPLETED"
                    Write-Verbose -Message "Removing Content Management Item $($item)"
                    Invoke-vLCMRestMethod -Method DELETE -URI $URI
                }

            }

        }

        catch [Exception] {

            throw

        }

    }
    end {

        #Finalize
        Write-Verbose -Message "Finalizing..."

    }


}

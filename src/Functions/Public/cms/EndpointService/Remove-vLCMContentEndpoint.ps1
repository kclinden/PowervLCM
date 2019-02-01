function Remove-vLCMContentEndpoint {
    <#
    .SYNOPSIS
    Remove a content endpoint from vRealize Lifecycle Manager content management service

    .DESCRIPTION
    Remove a content endpoint from vRealize Lifecycle Manager content management service

    .PARAMETER EndpointId
    The content endpoint to remove

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Remove content by content id
    Remove-vLCMContentEndpoint -EndpointId a50d0992-bf12-424e-8a4c-a502dba422bb


#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    Param (

        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("id")]
        [ValidateNotNullOrEmpty()]
        [String[]]$EndpointId

    )

    begin {
        #Initialize
        Write-Verbose -Message "Initializing..."

    }

    process {
        #Process
        Write-Verbose -Message "Processing..."

        try {

            foreach ($endpoint in $EndpointId) {
                if ($PSCmdlet.ShouldProcess($endpoint)) {
                    $URI = "/cms/api/v1/endpoints/$($endpoint)"

                    #Invoke REST request
                    #This method will return an async request for the deletion operation.
                    #In a future version it would be better to capture that and track the status until it is "COMPLETED"
                    Write-Verbose -Message "Removing Content Management Endpoint $($endpoint)"
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

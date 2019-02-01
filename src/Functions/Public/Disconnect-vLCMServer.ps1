function Disconnect-vLCMServer {
    <#
    .SYNOPSIS
    Disconnect from a vLCM server

    .DESCRIPTION
    Disconnect from a vLCM server by removing the authorization token and the global vLCMConnection variable from PowerShell

    .EXAMPLE
    Disconnect-vLCMServer

    .EXAMPLE
    Disconnect-vLCMServer -Confirm:$false
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Low")]

    Param ()

    # --- Test for existing connection to vLCM
    if (-not $Global:vLCMConnection) {

        throw "vLCM Connection variable does not exist. Please run Connect-vLCMServer first to create it"
    }

    if ($PSCmdlet.ShouldProcess($Global:vLCMConnection.Server)) {

        try {

            # --- Remove the token from vLCM and remove the global PowerShell variable
            $URI = "/lcm/api/v1/logout"
            Invoke-vLCMRestMethod -Method POST -URI $URI -Verbose:$VerbosePreference

            # --- Remove custom Security Protocol if it has been specified
            if ($Global:vLCMConnection.SslProtocol -ne 'Default') {

                if (!$IsCoreCLR) {

                    [System.Net.ServicePointManager]::SecurityProtocol -= [System.Net.SecurityProtocolType]::$($Global:vLCMConnection.SslProtocol)
                }
            }

        }
        catch [Exception] {

            throw

        }
        finally {

            Write-Verbose -Message "Removing vLCMConnection global variable"
            Remove-Variable -Name vLCMConnection -Scope Global -Force -ErrorAction SilentlyContinue

        }

    }

}

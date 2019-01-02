function Invoke-vLCMRestMethod {
<#
    .SYNOPSIS
    Wrapper for Invoke-RestMethod/Invoke-WebRequest with vLCM specifics

    .DESCRIPTION
    Wrapper for Invoke-RestMethod/Invoke-WebRequest with vLCM specifics

    .PARAMETER Method
    REST Method:
    Supported Methods: GET, POST, PUT,DELETE

    .PARAMETER URI
    API URI, e.g. /lcm/api/v1/view/datacenter

    .PARAMETER Headers
    Optionally supply custom headers

    .PARAMETER Body
    REST Body in JSON format

    .PARAMETER OutFile
    Save the results to a file

    .PARAMETER WebRequest
    Use Invoke-WebRequest rather than the default Invoke-RestMethod

    .INPUTS
    System.String
    Switch

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Invoke-vLCMRestMethod -Method GET -URI '/lcm/api/v1/view/datacenter'
-
    .EXAMPLE
    $JSON = @"
      {
        "datacenterName": "CHICAGO_DATA_CENTER",
        "city": "Chicago",
        "country": "US",
        "latitude": "41.8781",
        "longitude": "87.6298",
        "state": "Illinois"
      }
    "@

    Invoke-vLCMRestMethod -Method PUT -URI '/lcm/api/v1/view/datacenter' -Body $JSON -WebRequest
#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$true, ParameterSetName="Standard")]
        [Parameter(Mandatory=$true, ParameterSetName="Body")]
        [Parameter(Mandatory=$true, ParameterSetName="OutFile")]
        [ValidateSet("GET","POST","PUT","DELETE")]
        [String]$Method,

        [Parameter(Mandatory=$true, ParameterSetName="Standard")]
        [Parameter(Mandatory=$true, ParameterSetName="Body")]
        [Parameter(Mandatory=$true, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [String]$URI,

        [Parameter(Mandatory=$false, ParameterSetName="Standard")]
        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.IDictionary]$Headers,

        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [ValidateNotNullOrEmpty()]
        [String]$Body,

        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [String]$OutFile,

        [Parameter(Mandatory=$false, ParameterSetName="Standard")]
        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [Switch]$WebRequest
    )

    # --- Test for existing connection to vLCM
    if (-not $Global:vLCMConnection){

        throw "vLCM Connection variable does not exist. Please run Connect-vLCMServer first to create it"
    }

    # --- Create Invoke-RestMethod Parameters
    $FullURI = "$($Global:vLCMConnection.Server)$($URI)"

    # --- Add default headers if not passed
    if (!$PSBoundParameters.ContainsKey("Headers")){

        $Headers = @{

            "Accept"="application/json";
            "Content-Type" = "application/json";
            "x-xenon-auth-token" = "$($Global:vLCMConnection.Token)";
        }
    }

    # --- Set up default parmaeters
    $Params = @{

        Method = $Method
        Headers = $Headers
        Uri = $FullURI
    }

    if ($PSBoundParameters.ContainsKey("Body")) {

        $Params.Add("Body", $Body)

        # --- Log the payload being sent to the server
        Write-Debug -Message $Body

    } elseif ($PSBoundParameters.ContainsKey("OutFile")) {

        $Params.Add("OutFile", $OutFile)

    }

    # --- Support for PowerShell Core certificate checking
    if (!($Global:vLCMConnection.SignedCertificates) -and ($IsCoreCLR)) {

        $Params.Add("SkipCertificateCheck", $true);
    }

    # --- Support for PowerShell Core SSL protocol checking
    if (($Global:vLCMConnection.SslProtocol -ne 'Default') -and ($IsCoreCLR)) {

        $Params.Add("SslProtocol", $Global:vLCMConnection.SslProtocol);
    }

    try {

        # --- Use either Invoke-WebRequest or Invoke-RestMethod
        if ($PSBoundParameters.ContainsKey("WebRequest")) {

            Invoke-WebRequest @Params
        }
        else {

            Invoke-RestMethod @Params
        }
    }
    catch {

        throw $_
    }
    finally {

        if (!$IsCoreCLR) {

            <#
                Workaround for bug in Invoke-RestMethod. Thanks to the PowerNSX guys for pointing this one out
                https://bitbucket.org/nbradford/powernsx/src
            #>
            $ServicePoint = [System.Net.ServicePointManager]::FindServicePoint($FullURI)
            $ServicePoint.CloseConnectionGroup("") | Out-Null
        }
    }
}

<#
.DESCRIPTION
This script will capture all content for a given time from a vRealize Lifecycle Manager Content Endpoint.

.NOTES
Procedures
1. Install PowervLCM Module (ALPHA)
2. Configure Content Endpoints in LCM
3, Get the Content Endpoint Name and ID via Get-vLCMContentEndpoint
4. Invoke the script with the appropriate parameters

.EXAMPLE
./captureAllContent.ps1 -Server lcmserver.domain -Credential $cred -EndpointId $endpointId -ContentEndpointName $contentEndpoint -TemplatePath ./template.json -CaptureType Automation-Software
#>


param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [Management.Automation.PSCredential]$Credential,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$Server,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$EndpointId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$ContentEndpointName,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$TemplatePath,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("Automation-CompositeBlueprint", "Automation-ComponentProfile", "Automation-PropertyDefinition", "Automation-PropertyGroup", "Automation-ResourceAction", "Automation-Software", "Automation-Subscription", "Automation-XaaSBlueprint")]
    [String]$CaptureType
)


function getContentList {

    Param (

        [Parameter(Mandatory = $true)]
        [String]$ContentType,

        [Parameter(Mandatory = $true)]
        [String]$EndpointId

    )

    #Get the list of items available on the selected Content Endpoint
    $list = (Invoke-vLCMRestMethod -Method GET -URI "/cms/api/v1/endpoints/$($EndpointId)/list/$($ContentType)?force=true").result

    $list

}

function captureContent {

    Param (
        [Parameter(Mandatory = $true)]
        [String]$ContentItem,

        [Parameter(Mandatory = $true)]
        [String]$ContentType,

        [Parameter(Mandatory = $true)]
        [String]$ContentEndpointName,

        [Parameter(Mandatory = $true)]
        [String]$TemplatePath

    )

    #import json template specified
    $Body = Get-Content $TemplatePath -Raw | ConvertFrom-Json

    $Body.contentName = $ContentItem
    $Body.contentType = $ContentType
    $Body.contentEndpointName = $contentEndpointName

    $Body = $Body | ConvertTo-Json -Depth 10

    #Create a new Pipeline Request with the JSON payload
    $req = Invoke-vLCMRestMethod -Method POST -URI "/cms/api/v1/pipelines/capture" -Body $Body

    #Return the request link to track the status
    $req.requestLink

}

function captureAllForType($CaptureType) {

    #Get the list of content for endpoint
    $content = getContentList -ContentType $ContentType -EndpointId $EndpointId

    $requestList = @()

    #Invoke Capture for each content on the content endpoint
    foreach ($item in $content) {
        $capture = captureContent -ContentItem $item -ContentType $ContentType -ContentEndpointName $contentEndpointName -TemplatePath $TemplatePath
        $requestList += $capture
    }

    #return list of all requests
    $requestList

}

function checkRequestStatus($link) {
    #Get the status of a request
    $status = (Invoke-vLCMRestMethod -Method GET -URI $link).requestStatus
    $status
}

################################
########### MAIN ###############
################################

Connect-vLCMServer -Server $Server -Credential $Credential -SslProtocol Tls12
$requestList = captureAllForType -ContentType $CaptureType #Capture All Content

#Check statuses until all are complete
$complete = $false
while ($complete -eq $false) {
    $statuses = @() #Init statuses
    foreach ($r in $requestList) {
        $status = checkRequestStatus($r)
        $r + " : " + $status
        $statuses += $status
    }
    if ($statuses -notcontains "IN_PROGRESS") {
        $complete = $true
    }
    else {
        "Still in progress... checking status again in 30 seconds"
        Start-Sleep -Seconds 30
    }
}

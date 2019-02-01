# Invoke-vLCMRestMethod

## SYNOPSIS
Wrapper for Invoke-RestMethod/Invoke-WebRequest with vLCM specifics

## SYNTAX

### Standard (Default)
```
Invoke-vLCMRestMethod -Method <String> -URI <String> [-Headers <IDictionary>] [-WebRequest]
 [<CommonParameters>]
```

### OutFile
```
Invoke-vLCMRestMethod -Method <String> -URI <String> [-Headers <IDictionary>] [-OutFile <String>] [-WebRequest]
 [<CommonParameters>]
```

### Body
```
Invoke-vLCMRestMethod -Method <String> -URI <String> [-Headers <IDictionary>] [-Body <String>] [-WebRequest]
 [<CommonParameters>]
```

## DESCRIPTION
Wrapper for Invoke-RestMethod/Invoke-WebRequest with vLCM specifics

## EXAMPLES

### EXAMPLE 1
```
The following commnad can be used to invoke a specific LCM REST API.
```

Invoke-vLCMRestMethod -Method GET -URI '/lcm/api/v1/view/datacenter'
-

### EXAMPLE 2
```
The following example creates a new LCM datacenter by submitted a JSON object to the REST API.
```

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

## PARAMETERS

### -Method
REST Method:
Supported Methods: GET, POST, PUT,DELETE

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URI
API URI, e.g.
/lcm/api/v1/view/datacenter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Headers
Optionally supply custom headers

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
REST Body in JSON format

```yaml
Type: String
Parameter Sets: Body
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
Save the results to a file

```yaml
Type: String
Parameter Sets: OutFile
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebRequest
Use Invoke-WebRequest rather than the default Invoke-RestMethod

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
### Switch
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS

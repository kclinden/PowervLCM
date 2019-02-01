# Get-vLCMContentItem

## SYNOPSIS
Get content item from vRealize Lifecycle Manager content management service

## SYNTAX

```
Get-vLCMContentItem [[-PackageType] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get all content or a single content by ID.

## EXAMPLES

### EXAMPLE 1
```
Get contnt by content id
```

Get-vLCMContent -Id 4e87ae12-75c8-4a8d-83ab-f02d30543a08

### EXAMPLE 2
```
Get all content and display in a table format
```

Get-vLCMContent | ft

## PARAMETERS

### -PackageType
The content type to get

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS

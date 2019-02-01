# Get-vLCMContentEndpoint

## SYNOPSIS
Get content endpoints from vRealize Lifecycle Manager content management service

## SYNTAX

```
Get-vLCMContentEndpoint [[-Category] <String>] [[-Limit] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get all content endpoints or a single content by ID.

## EXAMPLES

### EXAMPLE 1
```
Get content by content id
```

Get-vLCMContentEndpoint -Category SourceControl

### EXAMPLE 2
```
Get all content and display in a table format
```

Get-vLCMContentEndpoint | ft

## PARAMETERS

### -Category
The content endpoint category type to filter

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

### -Limit
Limit the number of objects returned.
Default = 100

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 100
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

# Add-vLCMContent

## SYNOPSIS
Captures a new content item via the vRealize Lifecycle Manager content management service

## SYNTAX

```
Add-vLCMContent [[-ContentType] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Captures a new content item via the vRealize Lifecycle Manager content management service

## EXAMPLES

### EXAMPLE 1
```
Get contnt by content id
```

Add-vLCMContent -Id 4e87ae12-75c8-4a8d-83ab-f02d30543a08

### EXAMPLE 2
```
Get all content and display in a table format
```

Add-vLCMContent | ft

## PARAMETERS

### -ContentType
Content Type that is being captured (Example: Automation-CompositeBlueprint)

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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

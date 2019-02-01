# Get-vLCMDatacenter

## SYNOPSIS
Get dacenter(s) from vRealize Lifecycle Manager

## SYNTAX

### Standard (Default)
```
Get-vLCMDatacenter [<CommonParameters>]
```

### ById
```
Get-vLCMDatacenter -Id <String[]> [<CommonParameters>]
```

## DESCRIPTION
Get all datacenters or a single datacenter by ID.

## EXAMPLES

### EXAMPLE 1
```
Get-vLCMDatacenter -Id 6da4b2a20c6b127557662cd1c8ff8
```

### EXAMPLE 2
```
Get-vLCMDatacenter
```

## PARAMETERS

### -Id
The id of the Datacenter

```yaml
Type: String[]
Parameter Sets: ById
Aliases:

Required: True
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

# Disconnect-vLCMServer

## SYNOPSIS
Disconnect from a vLCM server

## SYNTAX

```
Disconnect-vLCMServer [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Disconnect from a vLCM server by removing the authorization token and the global vLCMConnection variable from PowerShell

## EXAMPLES

### EXAMPLE 1
```
Disconnect-vLCMServer
```

### EXAMPLE 2
```
Disconnect-vLCMServer -Confirm:$false
```

## PARAMETERS

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

## OUTPUTS

## NOTES

## RELATED LINKS

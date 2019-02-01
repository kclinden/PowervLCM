# Connect-vLCMServer

## SYNOPSIS
Connect to a vLCM Server

## SYNTAX

### Username (Default)
```
Connect-vLCMServer -Server <String> -Username <String> -Password <SecureString> [-IgnoreCertRequirements]
 [-SslProtocol <String>] [<CommonParameters>]
```

### Credential
```
Connect-vLCMServer -Server <String> -Credential <PSCredential> [-IgnoreCertRequirements]
 [-SslProtocol <String>] [<CommonParameters>]
```

## DESCRIPTION
Connect to a vLCM Server and generate a connection object with Servername, Token etc

## EXAMPLES

### EXAMPLE 1
```
Connect-vLCMServer -Server vlcmappliance01.domain.local -Credential (Get-Credential)
```

## PARAMETERS

### -Server
vLCM Server to connect to

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

### -Username
Username to connect with

```yaml
Type: String
Parameter Sets: Username
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
Password to connect with

```yaml
Type: SecureString
Parameter Sets: Username
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credential object to connect with

```yaml
Type: PSCredential
Parameter Sets: Credential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreCertRequirements
Ignore requirements to use fully signed certificates

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

### -SslProtocol
Alternative Ssl protocol to use from the default
Windows PowerShell: Ssl3, Tls, Tls11, Tls12
PowerShell Core: Tls, Tls11, Tls12

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
### System.SecureString
### Management.Automation.PSCredential
### Switch
## OUTPUTS

### System.Management.Automation.PSObject
## NOTES

## RELATED LINKS

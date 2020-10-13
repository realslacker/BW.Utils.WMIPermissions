---
external help file: BW.Utils.WMIPermissions-help.xml
Module Name: BW.Utils.WMIPermissions
online version:
schema: 2.0.0
---

# Get-WmiNamespaceACL

## SYNOPSIS
Returns WMI ACL object

## SYNTAX

### Local (Default)
```
Get-WmiNamespaceACL [-Namespace] <String> [<CommonParameters>]
```

### Remote
```
Get-WmiNamespaceACL [-Namespace] <String> -ComputerName <String> [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Returns WMI ACL object

## EXAMPLES

### EXAMPLE 1
```
$ACL = Get-WmiNamespaceACL -Namespace 'root/cimv2'
```

## PARAMETERS

### -Namespace
Full namespace path

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Remote computer name

```yaml
Type: String
Parameter Sets: Remote
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Remote computer credential

```yaml
Type: PSCredential
Parameter Sets: Remote
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

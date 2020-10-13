---
external help file: BW.Utils.WMIPermissions-help.xml
Module Name: BW.Utils.WMIPermissions
online version:
schema: 2.0.0
---

# Set-WmiNamespaceACL

## SYNOPSIS
Sets WMI ACL object

## SYNTAX

### Local (Default)
```
Set-WmiNamespaceACL [-Acl] <ManagementBaseObject> [-Namespace] <String> [<CommonParameters>]
```

### Remote
```
Set-WmiNamespaceACL [-Acl] <ManagementBaseObject> [-Namespace] <String> -ComputerName <String>
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Sets WMI ACL object

## EXAMPLES

### EXAMPLE 1
```
$ACL | Set-WmiNamespaceACL -Namespace 'root/cimv2'
```

## PARAMETERS

### -Acl
ACL object to set

```yaml
Type: ManagementBaseObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Namespace
Full namespace path

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

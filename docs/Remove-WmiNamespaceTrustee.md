---
external help file: BW.Utils.WMIPermissions-help.xml
Module Name: BW.Utils.WMIPermissions
online version:
schema: 2.0.0
---

# Remove-WmiNamespaceTrustee

## SYNOPSIS
Removes trustee permission to WMI ACL object

## SYNTAX

### NTAccount
```
Remove-WmiNamespaceTrustee [-Acl] <ManagementBaseObject[]> [-NTAccount] <NTAccount> [-PassThru]
 [<CommonParameters>]
```

### SID
```
Remove-WmiNamespaceTrustee [-Acl] <ManagementBaseObject[]> [-SID] <SecurityIdentifier> [-PassThru]
 [<CommonParameters>]
```

## DESCRIPTION
Removes trustee permission to WMI ACL object

## EXAMPLES

### EXAMPLE 1
```
$ACL | Remove-WmiNamespaceTrustee -NTAccount 'DOMAIN\UserName'
```

## PARAMETERS

### -Acl
ACL object to modify

```yaml
Type: ManagementBaseObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NTAccount
NTAccount to remove

```yaml
Type: NTAccount
Parameter Sets: NTAccount
Aliases: User, Group, Account

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SID
SecurityIdentifier to remove

```yaml
Type: SecurityIdentifier
Parameter Sets: SID
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
{{ Fill PassThru Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

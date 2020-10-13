---
external help file: BW.Utils.WMIPermissions-help.xml
Module Name: BW.Utils.WMIPermissions
online version:
schema: 2.0.0
---

# Get-WmiNamespaceTrusteeRights

## SYNOPSIS
Returns trustee permission on an WMI ACL object

## SYNTAX

### NTAccount
```
Get-WmiNamespaceTrusteeRights [-Acl] <ManagementBaseObject[]> [-NTAccount] <NTAccount>
 [[-AccessType] <WmiAccessType>] [<CommonParameters>]
```

### SID
```
Get-WmiNamespaceTrusteeRights [-Acl] <ManagementBaseObject[]> [-SID] <SecurityIdentifier>
 [[-AccessType] <WmiAccessType>] [<CommonParameters>]
```

## DESCRIPTION
Returns trustee permission on an WMI ACL object

## EXAMPLES

### EXAMPLE 1
```
$ACL | Get-WmiNamespaceTrusteeRights -NTAccount 'DOMAIN\UserName'
```

## PARAMETERS

### -Acl
ACL object

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
NTAccount to check

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
SecurityIdentifier to check

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

### -AccessType
Allow or Deny access

```yaml
Type: WmiAccessType
Parameter Sets: (All)
Aliases:
Accepted values: AccessAllowed, AccessDenied, Audit

Required: False
Position: 4
Default value: AccessAllowed
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

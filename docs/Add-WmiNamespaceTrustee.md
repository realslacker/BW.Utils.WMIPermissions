---
external help file: BW.Utils.WMIPermissions-help.xml
Module Name: BW.Utils.WMIPermissions
online version:
schema: 2.0.0
---

# Add-WmiNamespaceTrustee

## SYNOPSIS
Adds trustee permission to WMI ACL object

## SYNTAX

### NTAccount
```
Add-WmiNamespaceTrustee [-Acl] <ManagementBaseObject[]> [-Permissions] <WmiPermissions[]>
 [[-Inheritance] <WmiInheritance[]>] [[-AccessType] <WmiAccessType>] [-NTAccount] <NTAccount> [-PassThru]
 [<CommonParameters>]
```

### SID
```
Add-WmiNamespaceTrustee [-Acl] <ManagementBaseObject[]> [-Permissions] <WmiPermissions[]>
 [[-Inheritance] <WmiInheritance[]>] [[-AccessType] <WmiAccessType>] [-SID] <SecurityIdentifier> [-PassThru]
 [<CommonParameters>]
```

## DESCRIPTION
Adds trustee permission to WMI ACL object

## EXAMPLES

### EXAMPLE 1
```
$ACL | Add-WmiNamespaceTrustee -Permissions Enable -NTAccount 'DOMAIN\UserName'
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

### -Permissions
Permissions to be granted or denied by this ACE

```yaml
Type: WmiPermissions[]
Parameter Sets: (All)
Aliases:
Accepted values: Enable, MethodExecute, FullWrite, PartialWrite, ProviderWrite, RemoteAccess, Subscribe, Publish, ReadSecurity, WriteSecurity

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Inheritance
Type of inheritance for the ACE

```yaml
Type: WmiInheritance[]
Parameter Sets: (All)
Aliases:
Accepted values: ObjectInherit, ContainerInherit, NoPropagate, InheritOnly, Inherited

Required: False
Position: 4
Default value: ContainerInherit
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
Position: 5
Default value: AccessAllowed
Accept pipeline input: False
Accept wildcard characters: False
```

### -NTAccount
NTAccount to add

```yaml
Type: NTAccount
Parameter Sets: NTAccount
Aliases: User, Group, Account

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SID
SecurityIdentifier to add

```yaml
Type: SecurityIdentifier
Parameter Sets: SID
Aliases:

Required: True
Position: 6
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

<#
This module is based off work done by Steve Lee and Graeme Bray. The methods for
accessing and modifying WMI permissions were taken from the original script
Set-WMINameSpaceSecurity.ps1 located in TechNet. Without their work this module
would not be possible.

TechNet Link: https://gallery.technet.microsoft.com/Set-WMI-Namespace-Security-5081ad6d

Blog links:
   https://blogs.msdn.microsoft.com/wmi/2009/07/20/scripting-wmi-namespace-security-part-1-of-3/
   https://blogs.msdn.microsoft.com/wmi/2009/07/23/scripting-wmi-namespace-security-part-2-of-3/
   https://blogs.msdn.microsoft.com/wmi/2009/07/27/scripting-wmi-namespace-security-part-3-of-3/
   
#>

using namespace System.Security.Principal
using namespace System.Management

enum WmiPermissions {
    Enable           = 0x1     # WBEM_ENABLE
    MethodExecute    = 0x2     # WBEM_METHOD_EXECUTE
    FullWrite        = 0x4     # WBEM_FULL_WRITE_REP
    PartialWrite     = 0x8     # WBEM_PARTIAL_WRITE_REP
    ProviderWrite    = 0x10    # WBEM_WRITE_PROVIDER
    RemoteAccess     = 0x20    # WBEM_REMOTE_ACCESS
    Subscribe        = 0x40    # WBEM_RIGHT_SUBSCRIBE
    Publish          = 0x80    # WBEM_RIGHT_PUBLISH
    ReadSecurity     = 0x20000 # READ_CONTROL
    WriteSecurity    = 0x40000 # WRITE_DAC
}

enum WmiInheritance {
    ObjectInherit    = 0x1     # OBJECT_INHERIT_ACE
    ContainerInherit = 0x2     # CONTAINER_INHERIT_ACE
    NoPropagate      = 0x4     # NO_PROPAGATE_INHERIT_ACE
    InheritOnly      = 0x8     # INHERIT_ONLY_ACE
    Inherited        = 0x10    # INHERITED_ACE
}

enum WmiAccessType {
    AccessAllowed    = 0x0     # ACCESS_ALLOWED_ACE_TYPE
    AccessDenied     = 0x1     # ACCESS_DENIED_ACE_TYPE
    Audit            = 0x2     # AUDIT_ACE_TYPE
}


<#
.SYNOPSIS
 Returns WMI ACL object

.DESCRIPTION
 Returns WMI ACL object

.PARAMETER Namespace
 Full namespace path

.PARAMETER ComputerName
 Remote computer name

.PARAMETER Credential
 Remote computer credential

.EXAMPLE
 $ACL = Get-WmiNamespaceACL -Namespace 'root/cimv2'
#>
function Get-WmiNamespaceACL {

    [CmdletBinding(
        DefaultParameterSetName = 'Local'
    )]
    param(

        [Parameter(
            Mandatory,
            Position = 1
        )]
        [string]
        $Namespace,

        [Parameter(
            Mandatory,
            ParameterSetName = 'Remote'
        )]
        [string]
        $ComputerName,

        [Parameter(
            ParameterSetName = 'Remote'
        )]
        [pscredential]
        $Credential
    
    )

    $RemoteParams = @{}

    if ( $ComputerName ) { $RemoteParams.ComputerName = $ComputerName }
    if ( $Credential   ) { $RemoteParams.Credential   = $credential   }

    $Result = Invoke-WmiMethod -Namespace $Namespace -Path '__systemsecurity=@' -Name 'GetSecurityDescriptor' -ErrorAction Stop @RemoteParams

    if ( $Result.ReturnValue -ne 0 ) {

        throw ( 'Failed to get security descriptor. Method returned {0}.' -f $Result.ReturnValue )

    }
 
    $Result.Descriptor
        
}


<#
.SYNOPSIS
 Sets WMI ACL object

.DESCRIPTION
 Sets WMI ACL object

.PARAMETER Acl
 ACL object to set

.PARAMETER Namespace
 Full namespace path

.PARAMETER ComputerName
 Remote computer name

.PARAMETER Credential
 Remote computer credential

.EXAMPLE
 $ACL | Set-WmiNamespaceACL -Namespace 'root/cimv2'
#>
function Set-WmiNamespaceACL {

    [CmdletBinding(
        DefaultParameterSetName = 'Local'
    )]
    param(

        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipeline
        )]
        [ManagementBaseObject]
        $Acl,

        [Parameter(
            Mandatory,
            Position = 2
        )]
        [string]
        $Namespace,

        [Parameter(
            Mandatory,
            ParameterSetName = 'Remote'
        )]
        [string]
        $ComputerName,

        [Parameter(
            ParameterSetName = 'Remote'
        )]
        [pscredential]
        $Credential
    
    )

    $RemoteParams = @{}

    if ( $ComputerName ) { $RemoteParams.ComputerName = $ComputerName }
    if ( $Credential   ) { $RemoteParams.Credential   = $credential   }

    # set the new ACL
    $Result = Invoke-WmiMethod -Namespace $Namespace -Path '__systemsecurity=@' -Name 'SetSecurityDescriptor' -ArgumentList $Acl.psobject.immediateBaseObject -ErrorAction Stop @RemoteParams

    if ( $Result.ReturnValue -ne 0 ) {

        Write-Warning "SetSecurityDescriptor failed: $($Result.ReturnValue)"
    
    }
        
}


<#
.SYNOPSIS
 Adds trustee permission to WMI ACL object

.DESCRIPTION
 Adds trustee permission to WMI ACL object

.PARAMETER Acl
 ACL object to modify

.PARAMETER Permissions
 Permissions to be granted or denied by this ACE

.PARAMETER Inheritance
 Type of inheritance for the ACE

.PARAMETER AccessType
 Allow or Deny access

.PARAMETER NTAccount
 NTAccount to add

.PARAMETER SID
 SecurityIdentifier to add

.EXAMPLE
 $ACL | Add-WmiNamespaceTrustee -Permissions Enable -NTAccount 'DOMAIN\UserName'

#>
function Add-WmiNamespaceTrustee {

    [CmdletBinding()]
    param(

        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipeline
        )]
        [ManagementBaseObject[]]
        $Acl,

        [parameter(
            Mandatory,
            Position = 2
        )]
        [WmiPermissions[]]
        $Permissions,

        [parameter(
            Position = 3
        )]
        [WmiInheritance[]]
        $Inheritance = 'ContainerInherit',

        [parameter(
            Position = 4
        )]
        [WmiAccessType]
        $AccessType = 'AccessAllowed',

        [parameter(
            ParameterSetName = 'NTAccount',
            Mandatory,
            Position = 5
        )]
        [Alias( 'User', 'Group', 'Account' )]
        [ValidatePattern( '^(?# Matches DOMAIN\UserName )([^\\\/:*?"<>|.]+\\)?[^\\]+$' )]
        [NTAccount]
        $NTAccount,

        [Parameter(
            ParameterSetName = 'SID',
            Mandatory,
            Position = 5
        )]
        [SecurityIdentifier]
        $SID,

        [switch]
        $PassThru
    
    )

    begin {

        # if SID is not set, convert from NTAccount
        if ( -not $SID ) {

            $SID = $NTAccount.Translate( [SecurityIdentifier] )

        }
        
        # create a new ACE to add
        $Ace = [ManagementClass]::new('Win32_ACE').CreateInstance()

        # calculate access mask
        $Ace.AccessMask = $Permissions |
            Measure-Object -Sum |
            Select-Object -ExpandProperty Sum

        # set inheritance
        $Ace.AceFlags = $Inheritance |
            Measure-Object -Sum |
            Select-Object -ExpandProperty Sum

        # set access type
        $Ace.AceType = $AccessType

        # create a new trustee
        $Win32Trustee = [ManagementClass]::new('Win32_Trustee').CreateInstance()
        $Win32Trustee.SIDString = $SID.Value

        # attach the trustee to the ACE
        $Ace.Trustee = $Win32Trustee

    }

    process {

        $Acl | ForEach-Object {

            # attach the ACE to the ACL
            $_.DACL += $Ace.psobject.immediateBaseObject

            if ( $PassThru ) { $_ }

        }

    }

}


<#
.SYNOPSIS
 Removes trustee permission to WMI ACL object

.DESCRIPTION
 Removes trustee permission to WMI ACL object

.PARAMETER Acl
 ACL object to modify

.PARAMETER NTAccount
 NTAccount to remove

.PARAMETER SID
 SecurityIdentifier to remove

.EXAMPLE
 $ACL | Remove-WmiNamespaceTrustee -NTAccount 'DOMAIN\UserName'
#>
function Remove-WmiNamespaceTrustee {

    [CmdletBinding()]
    param(

        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipeline
        )]
        [ManagementBaseObject[]]
        $Acl,

        [parameter(
            ParameterSetName = 'NTAccount',
            Mandatory,
            Position = 2
        )]
        [Alias( 'User', 'Group', 'Account' )]
        [ValidatePattern( '^(?# Matches DOMAIN\UserName )([^\\\/:*?"<>|.]+\\)?[^\\]+$' )]
        [NTAccount]
        $NTAccount,

        [Parameter(
            ParameterSetName = 'SID',
            Mandatory,
            Position = 2
        )]
        [SecurityIdentifier]
        $SID,

        [switch]
        $PassThru
    
    )

    begin {

        # convert NTAccount to SID
        if ( -not $SID ) {

            $SID = $NTAccount.Translate( [SecurityIdentifier] )

        }
        
    }

    process {

        $Acl | ForEach-Object {
    
            # filter the DACL
            [ManagementBaseObject[]]$NewDACL = $_.DACL |
                Where-Object { $_.Trustee.SidString -ne $SID.Value }

            # attach the new DACL to the ACL
            $_.DACL = $NewDACL.psobject.immediateBaseObject

            if ( $PassThru ) { $_ }

        }

    }
    
}


<#
.SYNOPSIS
 Returns trustee permission on an WMI ACL object

.DESCRIPTION
 Returns trustee permission on an WMI ACL object

.PARAMETER Acl
 ACL object

.PARAMETER NTAccount
 NTAccount to check

.PARAMETER SID
 SecurityIdentifier to check

.PARAMETER AccessType
 Allow or Deny access

.EXAMPLE
 $ACL | Get-WmiNamespaceTrusteeRights -NTAccount 'DOMAIN\UserName'
 
#>
function Get-WmiNamespaceTrusteeRights {

    [CmdletBinding()]
    param(

        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipeline
        )]
        [ManagementBaseObject[]]
        $Acl,

        [parameter(
            ParameterSetName = 'NTAccount',
            Mandatory,
            Position = 2
        )]
        [Alias( 'User', 'Group', 'Account' )]
        [ValidatePattern( '^(?# Matches DOMAIN\UserName )([^\\\/:*?"<>|.]+\\)?[^\\]+$' )]
        [NTAccount]
        $NTAccount,

        [Parameter(
            ParameterSetName = 'SID',
            Mandatory,
            Position = 2
        )]
        [SecurityIdentifier]
        $SID,

        [parameter(
            Position = 3
        )]
        [WmiAccessType]
        $AccessType = 'AccessAllowed'
    
    )

    begin {

        # convert NTAccount to SID
        if ( -not $SID ) {

            $SID = $NTAccount.Translate( [SecurityIdentifier] )

        }
        
    }

    process {

        $Acl | ForEach-Object {
    
            # filter the DACL
            $_.DACL |
                Where-Object { $_.Trustee.SidString -eq $SID.Value -and $_.AceType -eq $AccessType } -PipelineVariable 'Ace' |
                ForEach-Object { [WmiPermissions].GetEnumValues() } |
                Where-Object { $_ -band [int]$Ace.AccessMask }

        }

    }
    
}

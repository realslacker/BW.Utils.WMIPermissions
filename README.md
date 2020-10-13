# BW.Utils.WMIPermissions
Utility module to modify WMI Namespace permissions.

This module is based off work done by Steve Lee and Graeme Bray. The methods for
accessing and modifying WMI permissions were taken from the original script
Set-WMINameSpaceSecurity.ps1 located in TechNet. Without their work this module
would not be possible.

TechNet Link:
 - https://gallery.technet.microsoft.com/Set-WMI-Namespace-Security-5081ad6d

Blog links:
- https://blogs.msdn.microsoft.com/wmi/2009/07/20/scripting-wmi-namespace-security-part-1-of-3/
- https://blogs.msdn.microsoft.com/wmi/2009/07/23/scripting-wmi-namespace-security-part-2-of-3/
- https://blogs.msdn.microsoft.com/wmi/2009/07/27/scripting-wmi-namespace-security-part-3-of-3/

## Installing
This module can be installed from the PSGallery

```powershell
Install-Module BW.Utils.WMIPermissions
```

## Usage
The most common usage is to grant access to WMI for some user to remotely run
queries. The simplest way to accomplish this goal is with the following code:

```powershell
PS C:\> $Group = Get-ADGroup 'GroupName'
PS C:\> $ACL = Get-WmiNamespaceACL -Namespace 'root/cimv2'
PS C:\> $ACL | Add-WmiNamespaceTrustee -Permissions Enable,RemoteAccess -Inheritance ContainerInherit -AccessType AccessAllowed -SID $Group.SID
PS C:\> $ACL | Set-WmiNamespaceACL -Namespace 'root/cimv2'
```

You can also take advantage of the pipeline for a one-liner:
```powershell
Get-WmiNamespaceACL -Namespace 'root/cimv2' | Add-WmiNamespaceTrustee -Permissions Enable,RemoteAccess -Inheritance ContainerInherit -AccessType AccessAllowed -SID (Get-ADGroup 'GroupName').SID -PassThru | Set-WmiNamespaceACL -Namespace 'root/cimv2'
```

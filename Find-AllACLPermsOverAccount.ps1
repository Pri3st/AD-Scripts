$Target = "<TARGET_ACCOUNT>"
$ACLs = Get-DomainObjectAcl -Identity $Target -ResolveGUIDs
$SIDs = $ACLs | Select-Object -ExpandProperty SecurityIdentifier -Unique

$Results = @()
foreach ($SID in $SIDs) {
    $Account = Convert-SidToName -ObjectSID $SID
    if ($Account) {
        $Results += [PSCustomObject]@{
            Account     = $Account
            SID         = $SID
            Permissions = ($ACLs | Where-Object { $_.SecurityIdentifier -eq $SID }).ActiveDirectoryRights -join ", "
        }
    }
}

$Results | Format-List *

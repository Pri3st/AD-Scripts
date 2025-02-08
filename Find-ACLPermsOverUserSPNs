$SID = (Get-DomainUser -Identity <CONTROLLED_ACCOUNT>).objectSID
$SPNUsers = Get-DomainUser -SPN | Select-Object -ExpandProperty samAccountName

$Results = @()
foreach ($User in $SPNUsers) {
    $ACLs = Get-DomainObjectAcl -Identity $User -ResolveGUIDs | Where-Object { $_.SecurityIdentifier -eq $SID }
    if ($ACLs) {
        $Results += [PSCustomObject]@{
            TargetUser = $User
            ACLs       = $ACLs
        }
    }
}

$Results | Format-List *

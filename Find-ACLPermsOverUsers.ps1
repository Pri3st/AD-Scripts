$SID = (Get-DomainUser -Identity <CONTROLLED_ACCOUNT>).objectSID
$Users = Get-DomainUser | Select-Object -ExpandProperty samAccountName

$Results = @()
foreach ($User in $Users) {
    $ACLs = Get-DomainObjectAcl -Identity $User -ResolveGUIDs | Where-Object { $_.SecurityIdentifier -eq $SID }
    if ($ACLs) {
        $Results += [PSCustomObject]@{
            TargetUser = $User
            ACLs       = $ACLs
        }
    }
}

$Results | Format-List *

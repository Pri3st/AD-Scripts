$SID = (Get-DomainUser -Identity <CONTROLLED_ACCOUNT>).objectSID
$SPNComputers = Get-DomainComputer | Select-Object -ExpandProperty samAccountName

# Iterate through each computer account and check ACLs
$Results = @()
foreach ($Computer in $SPNComputers) {
    $ACLs = Get-DomainObjectAcl -Identity $Computer -ResolveGUIDs | Where-Object { $_.SecurityIdentifier -eq $SID }
    if ($ACLs) {
        $Results += [PSCustomObject]@{
            TargetComputer = $Computer
            ACLs           = $ACLs
        }
    }
}

$Results | Format-List *

#update failed and suspended content index in DAG
Update-MailboxDatabaseCopy DB05\EX2016SRV2 -CatalogOnly -BeginSeed

#search admin audit log
search-adminauditlog -cmdlets set-mailbox -objectids megauser -startdate "01/01/2019" -enddate "06/21/2019" | foreach {$_.caller; $_.rundate ; $_.cmdletparameters} | fl

#mailboxdatabase size statistics
##simple
Get-MailboxDatabase -Status | select Name,DatabaseSize,AvailableNewMailboxSpace
##formated
Get-MailboxDatabase -Status | sort name | select name,@{Name='DB Size (Gb)';Expression={$_.DatabaseSize.ToGb()}},@{Name='Available New Mbx Space Gb)';Expression={$_.AvailableNewMailboxSpace.ToGb()}}

#Get Inbox Server Rules
get-mailbox "MegaUser" | get-inboxrule | fl

#get mailbox folder statistics 
get-mailbox "MegaUser" | get-mailboxfolderstatistics | select name, foldersize, itemsinfolder

#update GAL
Update-GlobalAddressList -Identity "Default Global Address List"

#update OAB
Update-OfflineAddressBook -Identity MyOABName

#show journaled databases
Get-mailboxdatabase | where {$_.journalrecipient -ne $null } | select name, journal*

#clear journaled settings
Get-mailboxdatabase | where {$_.journalrecipient -ne $null } | select name, journal* | set-mailboxdatabase -journalrecipient $null

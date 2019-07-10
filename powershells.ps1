#update failed and suspended content index in DAG
Update-MailboxDatabaseCopy DB05\EX2016SRV2 -CatalogOnly -BeginSeed

#search admin audit log
search-adminauditlog -cmdlets set-mailbox -objectids megauser -startdate "01/01/2019" -enddate "06/21/2019" | foreach {$_.caller; $_.rundate ; $_.cmdletparameters} | fl

#mailboxdatabase size statistics
##simple
Get-MailboxDatabase -Status | select Name,DatabaseSize,AvailableNewMailboxSpace
##formated
Get-MailboxDatabase -Status | sort name | select name,@{Name='DB Size (Gb)';Expression={$_.DatabaseSize.ToGb()}},@{Name='Available New Mbx Space Gb)';Expression={$_.AvailableNewMailboxSpace.ToGb()}}


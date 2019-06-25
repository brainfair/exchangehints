#update failed and suspended content index in DAG
Update-MailboxDatabaseCopy DB05\EX2016SRV2 -CatalogOnly -BeginSeed

#search admin audit log
search-adminauditlog -cmdlets set-mailbox -objectids megauser -startdate "01/01/2019" -enddate "06/21/2019" | foreach {$_.caller; $_.rundate ; $_.cmdletparameters} | fl

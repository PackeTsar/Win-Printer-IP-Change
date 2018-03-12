$old_ip=$args[0]
$new_ip=$args[1]



if (!$old_ip -Or !$new_ip) {
	echo `n;
	$fromps = $FALSE
	$old_ip = Read-Host 'Enter the Old Printer IP';
	$new_ip = Read-Host 'Enter the New Printer IP';
	echo `n;
} Else {
	$fromps = $TRUE
}

echo "Going from Old IP ($old_ip) to New IP ($new_ip)"

echo "Getting Printers and Ports"
$ports = Get-PrinterPort
$printers = Get-Printer


foreach ($port in $ports ){
	If ($port.PrinterHostAddress -eq $old_ip) {
		$pname = $port.Name;
		echo "Found Port: $port.Name"
	}
}

foreach ($printer in $printers ){
	If ($printer.PortName -eq $pname) {
		$myprintername = $printer.Name;
		echo "Found Printer: $printer.Name"
		break
	}
}

if (!$pname) {
	echo `n;
	Write-Host "Port Not Found. Exiting." -foreground Red;
	echo `n;
	if (!$fromps) {[void](Read-Host 'Press Enter to close window');Exit}  Else {Exit}
}
if (!$myprintername) {
	echo `n;
	Write-Host "Port found but no printer using it" -foreground Yellow;
	echo `n;
	[void](Read-Host 'Press Enter to delete the unused port...');
	echo "Deleting printer port $pname";
	Remove-PrinterPort -Name $pname;
	echo `n;
	Write-Host "Port removed" -foreground Green;
	echo `n;
	if (!$fromps) {[void](Read-Host 'Press Enter to close window');Exit} Else {Exit}
}

$newport = "PORT_$new_ip"

echo `n
Write-Host "Upon confirmation, we will be:" -foreground Green
Write-Host "    - Adding a new Printer Port ($newport) with IP ($new_ip)" -foreground Green
Write-Host "    - Applying new Printer Port ($newport) to Printer ($myprintername)" -foreground Green
Write-Host "    - Removing old Printer Port ($pname)" -foreground Green
echo `n
[void](Read-Host 'Press Enter to make IP switch...')


Add-PrinterPort -Name $newport -PrinterHostAddress $new_ip

Set-Printer -name $myprintername -PortName $newport

Remove-PrinterPort -Name $pname

echo `n
Write-Host "Modified $myprintername" -foreground Green
echo `n

[void](Read-Host 'Press Enter to print test page...')
 Invoke-CimMethod -MethodName printtestpage -InputObject (
	 Get-CimInstance win32_printer -Filter "name LIKE '$myprintername'")

[void](Read-Host 'Press Enter to check print jobs...')

Get-PrintJob -PrinterName $myprintername | Format-Table | Out-String|% {Write-Host -foreground Green $_}

if (!$fromps) {[void](Read-Host 'Press Enter to close window');Exit} Else {Exit}











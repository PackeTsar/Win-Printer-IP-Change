$old_ip=$args[0]
$new_ip=$args[1]

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

if (!$pname) { echo "Port Not Found. Exiting."; Exit }
if (!$myprintername) {
	[void](Read-Host 'Port found but no printer using it. Delete it?');
	echo "Deleting printer port $pname"
	Remove-PrinterPort -Name $pname;
	Exit
}

$newport = "IP_$new_ip"

echo "Adding Printer Port ($newport) with IP ($new_ip)"
echo "Applying Printer Port ($newport) to Printer ($myprintername)"
echo "Removing Old Printer Port ($pname)"
[void](Read-Host 'Press Enter to make IP switch...')


Add-PrinterPort -Name $newport -PrinterHostAddress $new_ip

Set-Printer -name $myprintername -PortName $newport

Remove-PrinterPort -Name $pname

echo "Modified $myprintername"

[void](Read-Host 'Press Enter to print test page…')
 Invoke-CimMethod -MethodName printtestpage -InputObject (
	 Get-CimInstance win32_printer -Filter "name LIKE '$myprintername'")

[void](Read-Host 'Press Enter to check print jobs...')

Get-PrintJob -PrinterName $myprintername













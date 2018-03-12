# Win-Printer-IP-Change
A simple script to automate the changing of the IP/hostname of a printer in Windows



-----------------------------------------
## VERSION
The version of Win-Printer-IP-Change documented here is: **v1.0.0**



-----------------------------------------
## HOW TO USE
Win-Printer-IP-Change is run from PowerShell with only two parameters: the old IP/hostname, and the new IP/hostname.

Example: `./Win-Printer-IP-Change.ps1 192.168.1.10 172.16.1.10`



-----------------------------------------
## WHAT IT DOES
- Win-Printer-IP-Change scans through all of the printer ports on the machine looking for the first parameter (the old IP/hostname). Once it finds the port, it scans through all the printers to find which one uses the port.
- Once it finds these two items, it creates a new printer port with the new IP/hostname, binds the printer to that port, then deletes the old port
- After this completes, it queues a test page to the printer to test and make sure the new port is working properly
- After the test page is queued, it prints out the current queue of the found printer
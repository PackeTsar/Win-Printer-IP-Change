# Win-Printer-IP-Change
A simple script to automate the changing of the IP/hostname of a printer in Windows



-----------------------------------------
## VERSION
The version of Win-Printer-IP-Change documented here is: **v1.0.0**



-----------------------------------------
## HOW TO USE
Win-Printer-IP-Change is run from PowerShell with only two parameters: the old IP/hostname, and the new IP/hostname.

May first need to: `Set-ExecutionPolicy -ExecutionPolicy Bypass`

Usage: `./Win-Printer-IP-Change.ps1 <old_IP_hostname> <new_IP_hostname>`

Example: `./Win-Printer-IP-Change.ps1 192.168.1.10 172.16.1.10`

-----------------------------------------
## WHAT IT DOES
- Win-Printer-IP-Change scans through all of the printer ports on the machine looking for the first parameter (the old IP/hostname). Once it finds the port, it scans through all the printers to find which one uses the port.
- Once it finds these two items, it creates a new printer port with the new IP/hostname, binds the printer to that port, then deletes the old port
- After this completes, it queues a test page to the printer to test and make sure the new port is working properly
- After the test page is queued, it prints out the current queue of the found printer



-----------------------------------------
## USAGE EXAMPLE
```
PS C:\Users\Administrator\Desktop\Win-Printer-IP-Change> .\Win-Printer-IP-Change.ps1 192.168.1.10 172.16.1.10
Going from Old IP (192.168.1.10) to New IP (172.16.1.10)
Getting Printers and Ports
Found Port: MSFT_TcpIpPrinterPort (Name = "PORT_192.168.1.10", ComputerName = "", PortMonitor = "TCPMON.DLL").Name
Found Printer: MSFT_Printer (Name = "MYPRINTER", ComputerName = "", Type = 0).Name


Upon confirmation, we will be:
    - Adding a new Printer Port (PORT_172.16.1.10) with IP (172.16.1.10)
    - Applying new Printer Port (PORT_172.16.1.10) to Printer (MYPRINTER)
    - Removing old Printer Port (PORT_192.168.1.10)


Press Enter to make IP switch...:


Modified MYPRINTER


Press Enter to print test page...:

                                                ReturnValue PSComputerName
                                                ----------- --------------
                                                          0
Press Enter to check print jobs...:

Id    ComputerName    PrinterName     DocumentName         SubmittedTime        JobStatus
--    ------------    -----------     ------------         -------------        ---------
12                    MYPRINTER       Test Page            3/12/2018 9:12:27 AM Printing, Re...





PS C:\Users\administrator.C1ENGINEERING\Desktop>
```
# NOTICE - DO NOT EDIT this file in this folder. Copy this to a local .DEV folder and edit there.

# Before running these commands, you must have the USBIPD-WIN project installed on Windows.
# Follow the instructions at https://learn.microsoft.com/en-us/windows/wsl/connect-usb

# This script allows you to detach usb devices from WSL back to Windows without physically unplugging the USB device


# -- EDIT BELOW -- #

# UNCOMMENT THE NEXT TWO LINES AND EDIT THE BUS ID WITH THE CORRECT ONE FOR YOUR USB DEVICE (use `usbipd list` to check your BUSID)
#usbipd deattach --busid <busid> 
#Write-Host "Don't forget to check to see that this device is available in WSL. Run `lsusb` in WSL to verify" -ForegroundColor Green 

# COMMENT THE NEXT LINE
Write-Host "NO USB DEVICE SET FOR ATTACHING. EDIT THIS SCRIPT AND UPDATE THE LINE ABOVE THIS ONE." -ForegroundColor Red 

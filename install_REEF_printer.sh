#!/bin/bash
read -p "Enter UF username: " UFUSERNAME
read -p "Enter UF password: " UFPASSWORD
UFPASSWORD=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]), "\n"' "$UFPASSWORD")
DEVICEURI=smb://$UFUSERNAME:$UFPASSWORD@ad.ufl.edu/TSS-SRV-Print-2.ad.ufl.edu/ENG-REEF142-PRT-C7030_BW
wget https://download.support.xerox.com/pub/drivers/VLC7000/drivers/linux/ar/VersaLink_C7000_5.739.0.0_PPD.zip
unzip -p VersaLink_C7000_5.739.0.0_PPD.zip Linux/English/xrxC7030.ppd >xrxC7030.ppd
sudo lpadmin -p REEFxerox -E -v "$DEVICEURI" -i './xrxC7030.ppd'
unset UFUSERNAME
unset UFPASSWORD
unset DEVICEURI
echo Printing Test Page
lpr -P REEFxerox /usr/share/cups/data/testprint
sleep 5
echo Printer Status:
output=lpstat -p REEFxerox
if [[ "$output" == "printer REEFxerox is idle."* ]]; then
  echo '🎉Congrats you have successfully added the REEF printer!🎉 Please pickup your test page from the printer in the front office.'
else
  echo '🚩Adding the printer was unsuccessful🚩 Error output:'
  echo $output
fi

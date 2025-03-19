sudo sed -i "s/^#Domains=.*$/Domains=local/g" "/etc/systemd/resolved.conf"
sudo sed -i "s/^#LLMNR=no.*$/LLMNR=no/g" "/etc/systemd/resolved.conf"
sudo sed -i "s/^#MulticastDNS=no.*$/MulticastDNS=yes/g" "/etc/systemd/resolved.conf"
current_interface=$(ip route get 8.8.8.8 | awk '{print $5}')
connection_name=$(nmcli device show $current_interface | awk '/GENERAL.CONNECTION:/ {gsub(/^GENERAL.CONNECTION:\s*/, ""); print}' | tr -s '[:space:]' | sed 's/^ *//')
sudo systemd-resolve --set-mdns=yes --interface=$current_interface
sudo nmcli connection modify "pathfinder5" connection.mdns yes
sudo nmcli connection modify "$connection_name" connection.mdns yes
sudo systemctl restart systemd-resolved.service

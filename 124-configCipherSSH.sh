#!/bin/bash

# Update OpenSSH and install necessary packages
#sudo yum -y update
sudo yum -y install openssh-server

# Set secure ciphers in the SSH configuration file
#sudo sed -i 's/^Ciphers.*/Ciphers aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes256-cbc/' /etc/ssh/sshd_config
#sudo sed -i 's/^MACs.*/MACs hmac-sha2-256-etm@openssh.com/' /etc/ssh/sshd_config
printf "
Ciphers aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes256-cbc
MACs hmac-sha2-256-etm@openssh.com
" >> /etc/ssh/sshd_config
 # /usr/share/crypto-policies/policies/DEFAULT.pol  Remove the week ciphers from here as well
    # Check the previous command resutl
    if [ $? -eq 0 ]; then
        echo " "
        echo "------------------------------------------------------------------------"
        echo "The Cipher parameters has been addedd successfully to /etc/ssh/sshd_config"
    else
        echo " "
        echo "------------------------------------------------------------------------"    
        echo "Failed to add the Cipher parameters to /etc/ssh/sshd_config"
    fi

# Restart the SSH service
sudo systemctl restart sshd

echo "SSH configuration updated and service restarted."

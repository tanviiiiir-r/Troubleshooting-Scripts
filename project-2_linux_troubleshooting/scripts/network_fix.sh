#!/bin/bash

LOG_FILE="../logs/network_fix.log"
mkdir -p ../logs
echo "$(date) - Running network diagnostics" | tee -a $LOG_FILE

# Check if connected to the internet
echo "🔍 Checking internet connection..."
ping -c 3 8.8.8.8 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Internet is working" | tee -a $LOG_FILE
else
    echo "❌ No internet detected. Running network fixes..." | tee -a $LOG_FILE

    # Identify active network interface
    INTERFACE=$(ip route | grep default | awk '{print $5}')
    echo "🌐 Active network interface: $INTERFACE" | tee -a $LOG_FILE

    # Restart networking services
    echo "🔄 Restarting NetworkManager..." | tee -a $LOG_FILE
    sudo systemctl restart NetworkManager

    # Fix possible DNS issues
    echo "🛠 Resetting DNS settings..." | tee -a $LOG_FILE
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

    echo "✅ Network fixes applied. Try again!" | tee -a $LOG_FILE
fi


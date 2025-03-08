#!/bin/bash

LOG_FILE="../logs/kali_update_fix.log"
mkdir -p ../logs
echo "$(date) - Running Kali update and fix" | tee -a $LOG_FILE

echo "🗑 Cleaning package cache..." | tee -a $LOG_FILE
sudo apt clean | tee -a $LOG_FILE

echo "🔍 Checking for missing dependencies..." | tee -a $LOG_FILE
sudo apt update --fix-missing | tee -a $LOG_FILE

echo "⬆️ Upgrading system..." | tee -a $LOG_FILE
sudo apt full-upgrade -y | tee -a $LOG_FILE

echo "🧹 Removing unnecessary packages..." | tee -a $LOG_FILE
sudo apt autoremove -y | tee -a $LOG_FILE
sudo apt autoclean | tee -a $LOG_FILE

echo "✅ Kali Linux is fully updated and optimized!" | tee -a $LOG_FILE

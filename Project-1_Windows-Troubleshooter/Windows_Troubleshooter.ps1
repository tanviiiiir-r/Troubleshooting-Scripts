# Request Admin Privileges if Needed
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Function to Check and Fix Network Issues
function Check-Network {
    Write-Host "Checking network connectivity..."
    $pingResult = Test-Connection -ComputerName google.com -Count 2 -ErrorAction SilentlyContinue
    if ($pingResult) {
        Write-Host "Network is working fine."
    } else {
        Write-Host "Network issue detected. Restarting network adapter..."
        Get-NetAdapter | Restart-NetAdapter -Confirm:$false
        Start-Sleep -Seconds 5
        Write-Host "Network adapter restarted."
    }
}

# Function to Clean Disk and Temporary Files
function Clean-Disk {
    Write-Host "Cleaning up temporary files and system junk..."
    Start-Process -FilePath "cleanmgr.exe" -ArgumentList "/sagerun:1" -NoNewWindow -Wait
    Write-Host "Disk cleanup completed."
}

# Function to Check Windows Update Issues (No Auto-Install)
function Check-WindowsUpdates {
    Write-Host "Checking for Windows updates (No Installation)..."
    
    # Ensure PSWindowsUpdate module is installed
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Write-Host "Installing PSWindowsUpdate module..."
        Install-Module PSWindowsUpdate -Force -Scope CurrentUser
        Import-Module PSWindowsUpdate
    }

    # Check for updates only (No installation)
    Get-WindowsUpdate -ErrorAction SilentlyContinue
    Write-Host "Windows update check completed."
}

# Function to Run System File Checker (SFC) and Repair System Files
function Repair-SystemFiles {
    Write-Host "Running System File Checker (SFC)..."
    Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -NoNewWindow -Wait
    Write-Host "SFC scan completed."

    Write-Host "Running DISM to fix system image..."
    Start-Process -FilePath "DISM.exe" -ArgumentList "/Online /Cleanup-Image /RestoreHealth" -NoNewWindow -Wait
    Write-Host "DISM repair completed."
}

# Main Function to Run All Troubleshooting Steps
function Run-Troubleshooter {
    Write-Host "Running Windows Troubleshooter..."
    Check-Network
    Clean-Disk
    Check-WindowsUpdates
    Repair-SystemFiles
    Write-Host "System troubleshooting complete."
}

# Execute Troubleshooter
Run-Troubleshooter


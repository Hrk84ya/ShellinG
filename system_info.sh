#!/bin/bash

# System Information Script for macOS
# Displays various system metrics and information

# Function to display section headers
section() {
    echo "\n===== $1 ====="
}

# Clear the screen
clear

# Display system header
echo "=============================="
echo "     SYSTEM INFORMATION"
echo "=============================="

# 1. System Information
section "SYSTEM INFORMATION"
echo "Hostname: $(hostname)"
echo "Operating System: $(sw_vers -productName) $(sw_vers -productVersion)"
echo "Kernel Version: $(uname -r)"
echo "Architecture: $(uname -m)"

# 2. CPU Information
section "CPU INFORMATION"
echo "CPU Model: $(sysctl -n machdep.cpu.brand_string)"
echo "CPU Cores: $(sysctl -n hw.ncpu)"
echo "Load Average: $(sysctl -n vm.loadavg | awk '{print $2, $3, $4}')"

# 3. Memory Information
section "MEMORY USAGE"
vm_stat | grep 'Pages free:'
echo ""
echo "Top 5 memory-consuming processes:"
ps -erco %mem,pid,comm -m | head -n 6

# 4. Disk Usage
section "DISK USAGE"
df -h | grep -v "map" | grep -v "devfs"

# 5. Uptime
section "SYSTEM UPTIME"
up=$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')
since=$(uptime | awk -F'up ' '{print $1}' | sed 's/^ *//')
echo "System Uptime: $up"
echo "Since: $since"

# 6. Network Information
section "NETWORK INFORMATION"
echo "Public IP: $(curl -s ifconfig.me)"
echo "Private IP(s): $(ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | tr '\n' ', ')"

echo "\n=============================="
echo "  END OF SYSTEM INFORMATION"
echo "=============================="

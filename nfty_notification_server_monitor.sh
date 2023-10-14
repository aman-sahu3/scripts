#!/bin/bash

# Function to monitor CPU usage
function monitor_cpu {
  cpu_usage=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2}')
  echo "CPU Usage: $cpu_usage%"
}

# Function to monitor RAM usage
function monitor_ram {
  ram_usage=$(free -m | grep "Mem:" | awk '{print $3}')
  echo "RAM Usage: $ram_usage MB"
}

# Function to send a notification via curl
function send_notification {
  message="Both CPU and RAM usage are high! Please check the server"
  curl "message=$message" https://e9e8-49-36-19-139.ngrok-free.app
}

function send_cpu_notification {
  message="CPU is running high"
  url="https://e9e8-49-36-19-139.ngrok-free.app/Monitor"
  curl -d "$message" "$url"
}

# Main program
echo "Server CPU and RAM Monitoring Script (One-Time)"

# Run CPU and RAM monitoring functions
monitor_cpu
monitor_ram

# Check conditions
if (( $(echo "$cpu_usage > 1" | bc -l) )) && ((ram_usage > 512)); then
  send_notification
  echo "Notification sent: $message"
elif (( $(echo "$cpu_usage > 1" | bc -l) )); then
  echo "CPU usage is high! Running a curl command for high CPU..."
  # Add your CPU-specific curl command here
  send_cpu_notification
  #echo "message=check the server " https://e9e8-49-36-19-139.ngrok-free.app
elif ((ram_usage > 512)); then
  echo "RAM usage is high! Running a curl command for high RAM..."
  # Add your RAM-specific curl command here
else
  echo "CPU and RAM usage are within acceptable limits."
fi


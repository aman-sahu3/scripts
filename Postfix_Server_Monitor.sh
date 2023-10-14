#!/bin/bash
# This script monitors CPU and memory usage

cpu_limit=50
mem_limit=800
email_address="steveettruth@gmail.com"

  # Get the current usage of CPU and memory
  cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
  memUsage=$(free -m | awk '/Mem/{print $3}')

  time=$(date)
        echo "$time" >> /home/monitor_logs/cpu_log.txt
        echo "CPU usage at this time was => "$cpuUsage""  >> /home/monitor_logs/cpu_log.txt
        echo "Memory usage at this time was => "$memUsage"" >> /home/monitor_logs/cpu_log.txt
        echo "" >> /home/monitor_logs/cpu_log.txt
        echo "" >> /home/monitor_logs/cpu_log.txt

  if
        [ $(echo "$cpuUsage >= $cpu_limit" | bc -l) -eq 1 ] && [ $(echo "$memUsage >= $mem_limit" | bc -l) -eq 1 ]; then
        #(( $(awk "BEGIN {print $cpuUsage > $cpu_limit && $memUsage > $mem_limit ? 1 : 0}") )); then
        subject="ALERT: High CPU Load Average on $(hostname) Server"
        body="Hello Aman,\n\n"
        body+="This is an automated notification to inform you that the CPU load average and Memory Usage on $(hostname) has exceeded the both threshold.\n\n"
        body+="Current Load Average: ${cpuUsage}\n"
        body+="Threshold: ${cpu_limit}\n\n"
        body+="Current Load Average: ${memUsage}\n"
        body+="Threshold: ${mem_limit}\n\n"
        body+="Please take appropriate actions to address the issue and prevent any performance degradation.\n\n"
        body+="Best regards,\n"
        body+="Your Monitoring System"

         echo -e "$body" | mail -s "$subject" "$email_address"

 elif
          (( $(echo "$cpuUsage > $cpu_limit" | bc -l) )); then
        subject="ALERT: High CPU Load Average on $(hostname) Server"
        body="Hello Aman,\n\n"
        body+="This is an automated notification to inform you that the CPU load average on $(hostname) has exceeded the threshold.\n\n"
        body+="Current Load Average: ${cpuUsage}\n"
        body+="Threshold: ${cpu_limit}\n\n"
        body+="Please take appropriate actions to address the issue and prevent any performance degradation.\n\n"
        body+="Best regards,\n"
        body+="Your Monitoring System"

         echo -e "$body" | mail -s "$subject" "$email_address"


 elif
         (( $(echo "$memUsage > $mem_limit" | bc -l) )); then
        subject="ALERT: High Memory Usgae on $(hostname) Server"
        body="Hello Aman,\n\n"
        body+="This is an automated notification to inform you that the Memory Usage on $(hostname) Server has exceeded the Memory limit.\n\n"
        body+="Current Memory usage: ${memUsage}\n"
        body+="Threshold: ${mem_limit}\n\n"
        body+="Please take appropriate actions to address the issue and prevent any performance degradation.\n\n"
        body+="Best regards,\n"
        body+="Your Monitoring System"

         echo -e "$body" | mail -s "$subject" "$email_address"

#break

  fi

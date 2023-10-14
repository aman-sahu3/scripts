#!/bin/bash

cpuUsage=90     # Replace with your actual CPU load average
cpu_limit=80    # Replace with your desired threshold

# Define the email content with HTML
email_body="<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            padding: 20px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        p {
            margin: 0 0 20px;
        }
    </style>
</head>
<body>
    <div class='container'>
        <h1>ALERT: High CPU Load Average on $(hostname) Server</h1>
        <p>Hello,</p>
        <p>This is an automated notification to inform you that the CPU load average on $(hostname) has exceeded the threshold.</p>
        <p>Current Load Average: $cpuUsage</p>
        <p>Threshold: $cpu_limit</p>
        <p>Please take appropriate actions to address the issue and prevent any performance degradation.</p>
        <p>Best regards,<br>Your Monitoring System</p>
    </div>
</body>
</html>"

# Send the email
echo "$email_body" | mail -a "Content-Type: text/html" -s "ALERT: High CPU Load Average on $(hostname) Server" recipient@example.com

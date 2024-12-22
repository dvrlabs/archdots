#!/bin/bash

sudo apt install wf-recorder v4l2loopback-utils v4l2loopback-dkms

# Create the systemd service file for v4l2loopback
echo "Creating /etc/systemd/system/v4l2loopback.service..."

sudo bash -c 'cat << EOF > /etc/systemd/system/v4l2loopback.service
[Unit]
Description=Load v4l2loopback module
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/sbin/modprobe v4l2loopback exclusive_caps=1 card_label=WfRecorder nr=0
ExecStop=/sbin/modprobe -r v4l2loopback
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF'

# Reload systemd to apply the new service
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service to start at boot
echo "Enabling v4l2loopback service to start at boot..."
sudo systemctl enable v4l2loopback.service

# Start the service immediately
echo "Starting v4l2loopback service..."
sudo systemctl restart v4l2loopback.service

# Check service status
echo "Service status:"
sudo systemctl status v4l2loopback.service

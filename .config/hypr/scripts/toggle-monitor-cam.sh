#!/bin/bash
# install deps if need to
# sudo apt install wf-recorder v4l2loopback-utils v4l2loopback-dkms

# Set the proper monitor to record.
monitor=DVI-D-1

# Function to start the camera
start_cam() {
    systemctl restart v4l2loopback

    # Start wf-recorder to capture the screen and feed it to /dev/video0
    wf-recorder -o $monitor --muxer=v4l2 --codec=rawvideo --file=/dev/video0 -x yuv420p &

    notify-send "Camera Recording on ${monitor}".

}

# Function to stop the camera and kill any lingering wf-recorder processes
stop_cam() {

    # Kill any wf-recorder processes
    pkill -9 wf-recorder

    notify-send "Camera stopped."
}

# Function to toggle camera state
toggle_cam() {

    if pgrep wf-recorder > /dev/null; then
        stop_cam
    else
        start_cam
    fi
}

# Check for argument and run the toggle
case "$1" in
    start)
        start_cam
        ;;
    stop)
        stop_cam
        ;;
    toggle)
        toggle_cam
        ;;
    *)
        echo "Usage: $0 {start|stop|toggle}"
        exit 1
        ;;
esac

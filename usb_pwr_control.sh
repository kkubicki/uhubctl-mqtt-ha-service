#!/bin/bash

# MQTT Broker Information
broker_address="localhost"
broker_port=1883
topic_prefix="usb_pwr_control/"

# USB Port Control Commands
POWER_ON="on"
POWER_OFF="off"

# Function to control USB port using uhubctl
control_usb_port() {
    port_number=$1
    action=$2
    sudo uhubctl -f -a $action -p $port_number -l 1 
}

# Function to handle MQTT messages
handle_message() {
    topic="$1"
    payload="$2"
    port_number=$(echo "$topic" | cut -d'/' -f2)

    if [ "$payload" = "$POWER_ON" ] || [ "$payload" = "$POWER_OFF" ]; then
        control_usb_port "$port_number" "$payload"
    else
        echo "Invalid command: $payload"
    fi
}

# Main function to listen for MQTT messages
listen_mqtt() {
    while true; do
        message=$(mosquitto_sub -v -h "$broker_address" -p "$broker_port" -t "${topic_prefix}#" -C 1)
        topic=$(echo "$message" | cut -d' ' -f1)
        payload=$(echo "$message" | cut -d' ' -f2-)
        handle_message "$topic" "$payload" &
    done
}

# Start listening for MQTT messages
listen_mqtt


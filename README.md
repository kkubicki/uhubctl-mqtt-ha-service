# uhubctl-mqtt-ha-service
A set of scripts to manipulate USB power using uhubctl tool via MQTT + Home Assistant integration.

MQTT protocol enables switching USB power on host machine without installing HAOS.

> [!NOTE]
> These scripts were created with chat-gpt's help

# installation
Following instruction was tested on Debian with Home Assistant running in Docker:
- Install `mosquitto-clients` and `uhubctl`
- Add to your `configuration.yaml` mqtt-switch entry, adjust USB port number if needed
- Place `usb_pwr_control.sh` in your home directory or other place of your choice, adjust broker address & port
- Put `usb_pwr_control.service` in the `/etc/systemd/system/` directory, adjust hub number (`-l` parameter) and path to `usb_pwr_control.sh` script
- Enable and start service, restart Home Assistant

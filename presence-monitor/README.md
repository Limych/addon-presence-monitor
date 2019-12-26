
# Configuration

**Note:** _Remember to restart the add-on when the configuration is changed._

Bluetooth Presence Monitor Hass.io add-on configuration:

```json
{
  "log_level": "info",
  "mqtt": {
    "broker": "127.0.0.1",
    "port": 1883,
    "username": "user",
    "password": "secret_password",
    "topic_root": "/presence",
    "publisher": "",
    "certfile": "",
    "version": ""
  },
  "known": {
    "beacons": [
      "00:00:00:00:00:00 nickname",
      "00:00:00:00:00:01 other_nickname"
    ],
    "static": [
      "00:00:00:00:00:02",
      "00:00:00:00:00:03 alias"
    ]
  },
  "blacklist": [
    "00:00:00:00:00:04"
  ]
}
```

**Note:** _This is just an example, don't copy and paste it! Create your own!_

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can be changed to be more or less verbose, which might be useful when you are dealing with an unknown issue. Possible values are:

* `trace`: Show every detail, like all called internal functions.
* `debug`: Shows detailed debug information.
* `info`: Normal (usually) interesting events.
* `warning`: Exceptional occurrences that are not errors.
* `error`: Runtime errors that do not require immediate action.
* `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a more severe level, e.g., `debug` also shows `info` messages. By default, the `log_level` is set to `info`, which is the recommended setting unless you are troubleshooting.

<p align="center">* * *</p>
I put a lot of work into making this repo and component available and updated to inspire and help others! I will be glad to receive thanks from you — it will give me new strength and add enthusiasm:
<p align="center"><br>
<a href="https://www.patreon.com/join/limych?" target="_blank"><img src="http://khrolenok.ru/support_patreon.png" alt="Patreon" width="250" height="48"></a>
<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=UAGFL5L6M8RN2&item_name=[presence-monitor]+Donation+for+a+big+barrel+of+coffee+:)&currency_code=EUR&source=url" target="_blank"><img src="http://khrolenok.ru/support_paypal.png" alt="PayPal" width="250" height="48"></a>
<br>or&nbsp;support via Bitcoin or Etherium:<br>
<a href="https://sochain.com/a/mjz640g" target="_blank"><img src="http://khrolenok.ru/support_bitcoin.png" alt="Bitcoin" width="150"><br>
16yfCfz9dZ8y8yuSwBFVfiAa3CNYdMh7Ts</a>
</p>

### Option group `mqtt`

---

The following options are only for the option group: `mqtt`. They determine the settings for connecting to the MQTT-server.

#### Option `mqtt`: `broker`

This option allows you to change hostname or IP-address of MQTT-server to which add-on connect.
If you use official Hass.io "Mosquitto broker" add-on or Community Hass.io "MQTT Server & Web client" add-on you don't need to change it. 

#### Option `mqtt`: `port`

This option allows you to change port of MQTT-server to which add-on connect.
If you use official Hass.io "Mosquitto broker" add-on or Community Hass.io "MQTT Server & Web client" add-on you don't need to change it. 

#### Option `mqtt`: `username`

This option allows you to change the username which add-on use to connect to MQTT-server.

**Note**: _This option is required, but not set by default._

#### Option `mqtt`: `password`

This option allows you to change the password which add-on use to connect to MQTT-server.

**Note**: _This option is required, but not set by default._

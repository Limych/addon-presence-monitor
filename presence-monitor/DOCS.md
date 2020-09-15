# Home Assistant Add-on: Bluetooth Presence Monitor

Passive Bluetooth presence detection of beacons, cell phones, and other Bluetooth devices.

This add-on actually is a usage convenient shell for launching [the Andrew J Freyer's monitor script](https://github.com/andrewjfreyer/monitor) on the same machine where the Home Assistant itself works.
This script useful for MQTT-based home automation, especially when the script runs on multiple devices, distributed throughout a property.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

1. Search for the "Bluetooth Presence Monitor" add-on in the group "Limych's Hass.io Add-ons" in the Hass.io add-on store and install it.
1. Configure the add-on. Especially MQTT username and password options.
1. Start the "Bluetooth Presence Monitor" add-on.
1. Check the logs of the "Bluetooth Presence Monitor" add-on to see if everything went well.

<p align="center">* * *</p>
I put a lot of work into making this repo and component available and updated to inspire and help others! I will be glad to receive thanks from you — it will give me new strength and add enthusiasm:
<p align="center"><br>
<a href="https://www.patreon.com/join/limych?" target="_blank"><img src="http://khrolenok.ru/support_patreon.png" alt="Patreon" width="250" height="48"></a>
<br>or&nbsp;support via Bitcoin or Etherium:<br>
<a href="https://sochain.com/a/mjz640g" target="_blank"><img src="http://khrolenok.ru/support_bitcoin.png" alt="Bitcoin" width="150"><br>
16yfCfz9dZ8y8yuSwBFVfiAa3CNYdMh7Ts</a>
</p>

## Configuration

**Note:** _Remember to restart the add-on when the configuration is changed._

Bluetooth Presence Monitor Hass.io add-on configuration:

```yaml
# Note:
# This is just an example, don't copy and paste it!
# Create your own!

log_level: info
mqtt:
  broker: 127.0.0.1
  port: 1883
  username: '!secret mqtt_username'   # Yes, you can use
  password: '!secret mqtt_password'   # secrets in config :)
  topic_root: 'presence'
  publisher: ''             # Autoselect publisher identity
known:
  beacons:
    - '00:00:00:00:00:00 nickname'
    - '00:00:00:00:00:01 other_nickname'
  static:
    - '00:00:00:00:00:02'
    - '00:00:00:00:00:03 alias'
blacklist:
  - '00:00:00:00:00:04'
extra_arguments: "-a -x -b -tdr"
```

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can be changed to be more or less verbose, which might be useful when you are dealing with an unknown issue. Possible values are:

* `trace`: Show every detail, like all called internal functions.
* `debug`: Shows detailed debug information.
* `info`: Normal (usually) interesting events.
* `warning`: Exceptional occurrences that are not errors.
* `error`: Runtime errors that do not require immediate action.
* `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a more severe level, e.g., `debug` also shows `info` messages. By default, the `log_level` is set to `info`, which is the recommended setting unless you are troubleshooting.


### Option group `mqtt`

---

The following options are only for the option group: `mqtt`. They determine the settings for connecting to the MQTT-server.

#### Option `mqtt`: `broker`

This option allows you to change hostname or IP-address of MQTT-server to which add-on connect.

**Default value**: _"127.0.0.1"_ (same device)

**Note**: _If you use official Hass.io "Mosquitto broker" add-on or Community Hass.io "MQTT Server & Web client" add-on you don't need to change it._

#### Option `mqtt`: `port`

This option allows you to change port of MQTT-server to which add-on connect.

**Default value**: _1883_

**Note**: _If you use official Hass.io "Mosquitto broker" add-on or Community Hass.io "MQTT Server & Web client" add-on with default ports settings you don't need to change it._

#### Option `mqtt`: `username`

This option allows you to set the username which add-on use to connect to MQTT-server.

**Default value**: _""_ (empty)

#### Option `mqtt`: `password`

This option allows you to set the password which add-on use to connect to MQTT-server.

**Default value**: _""_ (empty)

#### Option `mqtt`: `topic_root`

This option allows you to change the root of MQTT topics branch the Bluetooth Presence Monitor will publish data to.

**Default value**: _"presence"_

**Note**: _If you have already configured presence monitors installed without this addon perhaps you need to change `topic_root` to "monitor"._

#### Option `mqtt`: `publisher`

This option allows you to change publisher identity of this Bluetooth Presence Monitor. Only this value allows you to distinguish one monitor instance from another one.

**Default value**: _""_ (empty)

**Note**: _If this field is empty (default value), the system will automatically substitute the hostname of the host device. This is usually "hassio"._

#### Option `mqtt`: `certfile`

**Default value**: _""_ (empty)

#### Option `mqtt`: `version`

**Default value**: _""_ (empty)

<p align="center">* * *</p>
I put a lot of work into making this repo and component available and updated to inspire and help others! I will be glad to receive thanks from you — it will give me new strength and add enthusiasm:
<p align="center"><br>
<a href="https://www.patreon.com/join/limych?" target="_blank"><img src="http://khrolenok.ru/support_patreon.png" alt="Patreon" width="250" height="48"></a>
<br>or&nbsp;support via Bitcoin or Etherium:<br>
<a href="https://sochain.com/a/mjz640g" target="_blank"><img src="http://khrolenok.ru/support_bitcoin.png" alt="Bitcoin" width="150"><br>
16yfCfz9dZ8y8yuSwBFVfiAa3CNYdMh7Ts</a>
</p>



### Option group `known`

---

The following options are only for the option group: `known`. They determine the unique ID's (MAC-addresses) of devices which you want to monitor.

**MAC-address format:** _"XX:XX:XX:XX:XX:XX" Where each X is a hexadecimal digit (0-9A-F)_

#### Option `known`: `beacons`

This option allow you to set list of MAC-addresses of [iBeacons](https://en.wikipedia.org/wiki/IBeacon) and similar devices which use a little different protocol.
Each device MUST be described in a separate list item.

**Items format:** _"{MAC-address} {nickname of device}"_

**Note**: _Nicknames are required._

#### Option `known`: `static`

This option allow you to set list of MAC-addresses of common devices.
Each device MUST be described in a separate list item.

**Items format:** _"{MAC-address} {alias of device}"_

**Note**: _Aliases are optional. If no alias is specified, the Presence Monitor will name the device by its MAC-address._



### Option `blacklist`

This option allow you to set list of MAC-addresses of devices you don't want to monitor.
Each device MUST be described in a separate list item.

**Items format:** _"{MAC-address}"_

### Option `extra_arguments`

Extra options to pass to presence monitor script. There are list of useful arguments for current version of script:

```text
-R      redact private information from logs
-S      silent operation (no logging)
-c addr create connection to bluetooth device
-C      clean retained messages from MQTT broker
-E      report scan status messages:
                [topic path]/scan/[arrive|depart]/[start|end]

-s  report all mqtt messages to a single topic with
                $mqtt_topicpath/$mqtt_publisher_identity  (defined in MQTT preferences file)

-f      format MQTT topics with only letters and numbers
-a      report all known device scan results, not just changes
-x      retain mqtt status messages
-b      report bluetooth beacons (e.g., generic beacons, ibeacons, and so on)
-t[adr] scan for known devices only on mqtt trigger messages:
                a $mqtt_topicpath/scan/ARRIVE (defined in MQTT preferences file)
                d $mqtt_topicpath/scan/DEPART (defined in MQTT preferences file)
                r send ARRIVE or DEPART messages to trigger other devices to scan
```

**Note:** _The `-b` option is adding automatically then you have one or more IDs in `known.beacons` section._

## Known issues and limitations

None

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We have set up a separate document containing our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this add-on is by [Andrey "Limych" Khrolenok][limych].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2019–2020 Andrey "Limych" Khrolenok

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[contributors]: https://github.com/Limych/addon-presence-monitor/graphs/contributors
[limych]: https://github.com/Limych
[releases]: https://github.com/Limych/addon-presence-monitor/releases
[semver]: http://semver.org/spec/v2.0.0.htm
[keepchangelog]: http://keepachangelog.com/en/1.0.0/

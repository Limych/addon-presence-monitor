*Please :star: this repo if you find it useful*

# Home Assistant Add-on: Bluetooth Presence Monitor

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE)

![Supports aarch64 Architecture](https://img.shields.io/badge/aarch64-yes-green.svg)
![Supports amd64 Architecture](https://img.shields.io/badge/amd64-yes-green.svg)
![Supports armhf Architecture](https://img.shields.io/badge/armhf-yes-green.svg)
![Supports armv7 Architecture](https://img.shields.io/badge/armv7-yes-green.svg)
![Supports i386 Architecture](https://img.shields.io/badge/i386-yes-green.svg)

[![Travis CI][travisci-shield]][travisci]
![Project Maintenance](https://img.shields.io/badge/maintainer-Andrey%20Khrolenok%20%40Limych-blue.svg?style=popout)
[![GitHub Activity][commits-shield]][commits]

[![GitHub pull requests](https://img.shields.io/github/issues-pr/Limych/addon-presence-monitor?style=popout)](https://github.com/Limych/addon-presence-monitor/pulls)
[![Bugs](https://img.shields.io/github/issues/Limych/addon-presence-monitor/bug.svg?colorB=red&label=bugs&style=popout)](https://github.com/Limych/addon-presence-monitor/issues?q=is%3Aopen+is%3Aissue+label%3Abug)

Passive Bluetooth presence detection of beacons, cell phones, and other Bluetooth devices.

## About

This add-on actually is a usage convenient shell for launching [the Andrew J Freyer's monitor script](https://github.com/andrewjfreyer/monitor) on the same machine where the Home Assistant itself works.
This script useful for MQTT-based home automation, especially when the script runs on multiple devices, distributed throughout a property.

## Features

* Convenient way to start indoor presence detection.
* You can use Home Assistant configuration secrets in add-on configuration.
* All necessary software is installed by itself. And regularly updated to the latest versions.
* The script is almost configured — just enter a couple of remaining settings.
* Complete freedom in reconfiguring the script to your needs.
* You can combine add-on and common versions of this presence monitor script in any combinations.

## Add add-on to Hass.io

Go to "ADD-ON STORE" on Hass.io screen and add the https://github.com/Limych/hassio-addons to "Add new repository by URL".

After that Limych's add-ons should show under the title: Limych's Hass.io Add-ons

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Hass.io add-on.

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

[:books: Read the full add-on documentation][docs]

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

[commits-shield]: https://img.shields.io/github/commit-activity/y/Limych/addon-presence-monitor.svg
[commits]: https://github.com/Limych/addon-presence-monitor/commits/master
[contributors]: https://github.com/Limych/addon-presence-monitor/graphs/contributors
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[license-shield]: https://img.shields.io/github/license/Limych/addon-presence-monitor.svg
[limych]: https://github.com/Limych
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[releases-shield]: https://img.shields.io/github/tag-date/Limych/addon-presence-monitor?label=release
[releases]: https://github.com/Limych/addon-presence-monitor/releases
[semver]: http://semver.org/spec/v2.0.0.htm
[travisci-shield]: https://img.shields.io/travis/Limych/addon-presence-monitor.svg
[travisci]: https://travis-ci.org/Limych/addon-presence-monitor/branches
[docs]: https://github.com/Limych/addon-presence-monitor/blob/master/presence-monitor/DOCS.md

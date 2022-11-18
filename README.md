# MonkeySwitcher
## General
Switch your Bluetooth capable devices like Magic Keyboard 2, Track Pad, AirPods, etc. between multiple Macs (e.g. personal & business) with a single click for macOS. This can especially be helpful to avoid connecting you wired USB-C to Lightning cable to your Magic Keyboard to establish a peering session to another Mac and may fasten up your workflow. However, initially this must be done on all Macs where you like to use this app to be a known and authorized Bluetooth device. This application ships binary versions for amd64 and arm64 architectures of [blueutil](https://github.com/toy/blueutil). More can be found within the [LICENSE.md](LICENSE.md) file.

## Usage
Installing and using this application is as easy as all other macOS application.

* Download [MonkeySwitcher-v0.8b.zip](https://gyptazy.ch/monkeyswitcher/MonkeySwitcher-v0.8b.zip)
* Unzip the file
* Drag the application to your Application folder
* Create the config file `.monkeyswitcher.config` in your home directory

### Config file
A config file must be created as `.monkeyswitcher.config` in your home directory where your underlying hardware architecture and the mac address of your Bluetooth device is defined.

```
# MonkeySwitcher config file
arch=arm64
btmac=00:00:00:00:00:00
```

If you are using a Apple Silicon based Mac (often also called M1 or M2) you need to define `arm64`, all other ones need to define `amd64`.

You can obtain the mac address of your to be managed bluetooth device by pressing and holding `alt` or `option` key on your keyboard an clicking on the bluetooth icon on your menu bar. It shows detailed information about your bluetooth devices.

## Building
### General
While this application is more or less a proof of concept for creating macOS application just by editing text files without any further compiler you can easily edit and adjust the code to your needs.
### Requirements
While this is a PoC which is only based on text file the file structure can be created manually. As a result, this should look like:

```
MonkeySwitcher.app
.
└── Contents
    ├── Info.plist
    ├── MacOS
    │   ├── blueutil_amd64
    │   ├── blueutil_arm64
    │   └── main.command
    └── Resources
        ├── English.lproj
        │   ├── InfoPlist.strings
        │   └── main.nib
        │       ├── designable.nib
        │       └── keyedobjects.nib
        └── cmd.icns
```

However, this is simplified and automated for demonstration by the `Makefile` and requires `make` which comes with the xcode command line dev tools which can be installed by running:

```
xcode-select --install
```

### Building
Building from scratch can be done by simply running the following command from the projects root directory:

```
$> make
```

Afterwards, you will find your ready to use application within the `.build` directory.

## Motivation
This app has been created after I switched from an older Bluetooth Apple Keyboard to the new Magic Keyboard. While the old one could just connect to any device while it was idle the new one refused to connect. I found similar solutions to solve this issue by other commercial apps but this was not the way to go for me. After a short look I found a hint regarding [blueutil](https://github.com/toy/blueutil), a cli tool for Bluetooth management on macOS, which is also available in [Homebrew](https://brew.sh) and [MacPorts](https://www.macports.org/). After writing a short Shell script this worked pretty fine and I decided to create a macOS app. However, there were too approaches:

 * Package a shell script as a macOS application
 * Create a native Swift macOS application

While this was in some case urgent to me I decided to stick with the Shell packaging approach which also should represent a PoC for packages script files as macOS application that can be used by everyone without further knowledge in Shell, Python etc. Just some days later some mates came back to me and loved this handy tool to switch (mostly) their keyboards at home between personal and business MacBooks. This is the motivation to create a native Swift application in the near future. So, stay tuned.

## FAQ
### The application can not be opened
Apple made several changes to make developers life hard when not publishing apps within the AppStore. Gatekeeper makes it more difficult to run unsigned application. However, you may still use this app.

Press and hold `control` (or `alt`) key on your keyboard while right clicking on the application and press open.

Afterwards, you may need to grant permissions to execute the application. As a result, go to the system settings, security, default and grant to start the app.

In some cases it may still be needed to remove the quarantine mode from the application by running:
```
sudo xattr -dr com.apple.quarantine MonkeySwitcher.app/
```
### Can is define more devices
Currently, you can only switch between single device within the config file. Multiple ones and a GUI mode will be part of the Swift rewrite.

### How do I use the app?
Running the application is a toggle - when the device is connected it gets disconnected. If the device is currently disconnected it gets connected.


## Support
First, please take a short look within the FAQ chapter if your question is already covered. If you need further help or found bugs feel free to raise an issue.

## Copyright
### MonkeySwitcher
* Florian Paul Azim Hoberg @gyptazy
### blueutil
* Frederik Seiffert
* Ivan Kuchin @toy
* Friedrich Weise @friedrich

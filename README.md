# TrackingNotifier

This tweak sends a notification to your iOS device when a locate command is received.

It is a great example tweak showcasing how to:

- Hook into a daemon
- Send notifications between processes
- Send bulletins (notifications) to the device using a custom BulletinBoard plugin

## Getting Started

### Prequisites

- [Xcode 4.6](https://itunes.apple.com/app/xcode/id497799835), which includes the iOS 6 SDK
- A jailbroken device running iOS 6

### Building

The first step to build the project is to clone the repository and initialize all of its submodules:

``` sh
git clone https://github.com/conradev/TrackingNotifier.git
cd TrackingNotifier
git submodule update --init -—recursive
```

To build the project, you need only run

```
make
```

### Installing

To install this on a jailbroken device, some additional tools are needed.

The first tool is `ldid`, which is used for fakesigning binaries. Ryan Petrich has a build on his [Github mirror](https://github.com/rpetrich/ldid):

``` sh
curl -O http://cloud.github.com/downloads/rpetrich/ldid/ldid.zip
unzip ldid.zip
mv ldid theos/bin/
rm ldid.zip
```

To build a Debian package, `dpkg` is required. You can install these using [Homebrew](http://mxcl.github.com/homebrew/):

``` sh
brew install dpkg
```

To build a package in the project directory, you can run:

``` sh
make package
```

and to automatically install this package on your jailbroken device (over SSH), you can run:

``` sh
make package install THEOS_DEVICE_IP=xxx.xxx.xxx.xxx
```

## License

TrackingNotifier is available under the MIT license. See the LICENSE file for more info.

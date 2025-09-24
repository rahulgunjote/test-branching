fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios custom_lane

```sh
[bundle exec] fastlane ios custom_lane
```

Description of what the lane does

### ios test

```sh
[bundle exec] fastlane ios test
```

Run all tests

### ios build

```sh
[bundle exec] fastlane ios build
```

Build the app

### ios build_and_test

```sh
[bundle exec] fastlane ios build_and_test
```

Build and test the app

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Take screenshots

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Deploy to TestFlight

### ios release

```sh
[bundle exec] fastlane ios release
```

Deploy to App Store

### ios increment_build

```sh
[bundle exec] fastlane ios increment_build
```

Increment build number

### ios increment_version

```sh
[bundle exec] fastlane ios increment_version
```

Increment version number

### ios setup_signing

```sh
[bundle exec] fastlane ios setup_signing
```

Setup code signing with match

### ios refresh_profiles

```sh
[bundle exec] fastlane ios refresh_profiles
```

Refresh provisioning profiles

### ios cut_release

```sh
[bundle exec] fastlane ios cut_release
```

Cut release with new release branch

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

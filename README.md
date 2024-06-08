# flutter_versioner plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-flutter_versioner)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-flutter_versioner`, add it to your project by running:

```bash
fastlane add_plugin flutter_versioner
```

## About flutter_versioner

Flutter versioner is a powerful fastlane plugin designed to simplify the management of flutter project version. With this you can easily update project version to any specified major,minor,or patch level as well as adjust the version code/build number.
## Syntax
```
flutter_versioner(pubspec_file_path:"../pubspec.yaml",
version_component:"major"
) 
```

### Options
1. pubspec_file_path - relative path to the pubspec file where the version is maintained
2. version_component - the component of version that need to be modified - **major.minor.patch+version_code**

    Values
    - major
    - minor
    - patch
    - version_code (default value)
3. value - the value given will be used to set the given version component. If `value` is not given the version compenent will be incremented by `1`

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins`.

### 1. VERSION CODE/BUILD NUMBER
#### a. Update the flutter version code by 1 

eg 1.1.1+1 -> 1.1.1+2

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
version_component:"version_code")
```
if you dont specify `version_component` version_code will the default value

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
value:"9")
```

#### b. Set the flutter version - patch to `value` given 

eg 1.1.1+1 -> 1.1.1+100
```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  value:"100",
  version_component:"version_code")
```
### 2. VERSION - PATCH
#### a. Update the flutter version - patch by 1 

eg 1.1.1 -> 1.1.2

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  version_component:"patch")
```
#### b. Set the flutter version - patch to `value` given 

eg 1.1.1 -> 1.1.100

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  value:"100",
  version_component:"patch")
```

### 3. VERSION - MINOR
#### a. Update the flutter version - minor by 1  (also reset patch to 0)

eg 1.1.1 -> 1.2.0
```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  version_component:"minor")
```

#### b. Set the flutter version - major to `value` given  (also reset patch to 0)

eg 1.1.1 -> 1.100.0
```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  value:"100",
  version_component:"minor")
```

### 4. VERSION - MAJOR
#### a. Update the flutter version - major by 1 (also reset minor and patch)

eg 1.1.1 -> 2.0.0

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  version_component:"major")
```

#### b. Set the flutter version - major to `value` given (also reset minor and patch)

eg 1.1.1 -> 100.0.0

```
flutter_versioner(pubspec_file_path:"./example/pubspec.yaml",
  value:"100",
  version_component:"major")
```


## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

## Meet the Team

<b>Abhijith Konnayil</b><br>
GitHub: [abhijithkonnayil](https://github.com/abhijithkonnayil)<br>
LinkedIn: [abhijithkonnayil](https://www.linkedin.com/in/abhijithkonnayil)<br>
Website: [abhijith.web.app](https://abhijith.web.app/)

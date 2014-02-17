# CLBlockObservation

[![Version](http://cocoapod-badges.herokuapp.com/v/CLBlockObservation/badge.png)](http://cocoadocs.org/docsets/CLBlockObservation)
[![Platform](http://cocoapod-badges.herokuapp.com/p/CLBlockObservation/badge.png)](http://cocoadocs.org/docsets/CLBlockObservation)

**No hassle Objective-C blocks-based KVO library with automatic removal**

There are so many KVO libraries out there. Couldn't find one that supports both blocks
and automatic removal of observers. And that's usually what I need. Just want to bind
stuff around.

## Installation

CLBlockObservation is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CLBlockObservation"

## Usage

Usage is straightforward. I would recommend including `<NSObject+CLBlockObservation.h>` 
in your `.pch` file.

```objective-c
[observee addObserver:observer keyPath:@"p1" block:^(id oldValue, id newValue) {
  NSLog(@"do something great!");
}];
```

There's also support for observing multiple keypaths:

```objective-c
[observee addObserver:observer keyPaths:@[ @"p1", @"p2" ] block:^{
  NSLog(@"be awesome!");  
}];
```

## Tests

There's an XCTest project in this repository. It contains a few tests that verify
the lifetime management of the observation and a good sample reference. To run it:

 1. Clone this repository
 2. Run `pod install` from the `./TestProject` directory
 3. Run tests from XCode (Command + U).

## Author

Elad Ben-Israel, elad.benisrael@gmail.com

## License

CLBlockObservation is available under the MIT license. See the LICENSE file for more info.
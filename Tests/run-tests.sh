#!/bin/bash
pod install
xcodebuild test -workspace CLBlockObservationTests.xcworkspace -scheme CLBlockObservationTests -sdk iphonesimulator7.0

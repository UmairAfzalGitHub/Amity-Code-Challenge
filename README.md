![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

Amity Todo application created for demo purposes.

## Features

- [x] Todo list with title and user info
- [x] List sorted by created dates
- [x] Only download if url has changed
- [x] Error handling with alerts
- [x] Seach items by title and description
- [x] Task detail screen
- [x] Empty veiw message

## Requirements

- iOS 13.0+
- Xcode 11+
- Swift 5+

## Design Pattern: Model-View-ViewModel (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Model 
  - hold application data. They’re usually structs or simple classes.
- #### View 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View Model
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

## Dependencies

- [IQKeyBoardManager](https://github.com/hackiftekhar/IQKeyboardManager)
- [Alamofire Image](https://github.com/Alamofire/AlamofireImage)

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To run the project:
- Open terminal
- `cd` into your top-level project directory
- Run the followinfg command: pod install

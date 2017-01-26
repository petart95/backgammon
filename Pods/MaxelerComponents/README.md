# MaxelerComponents

This project contains all the files necessary for fast development of new iOS applications. 

There are 4 main parts:
* Layout - consisted of:
    * IdiomAndOrientation - Responsible for type(phone or iPad) and orientation(portrait and landscape) of device.
    * UIResponder+Layout - Responsible for custom layout (superclass of UIView and UIViewController).
    * UIView+Layout - Responsible for custom layout.
* MaxelerAppDelegate - Subclass of AppDelegate responsible for starting the app without the storyboard.
* MaxelerNavigationController - consisted of:
    * MaxelerNavigationBar - Subclass of UINavigationBar with custom options.
    * MaxelerToolbar - Subclass of UIToolbar with custom options.
    * NSBundle+MaxelerComponents - Returns path to MaxelerComponents framework and bundle.
    * UINavigationController+ShowViewController - Adds option to show navigation controller with given class or name.
    * MaxelerNavigationController - Subclass of UINavigationController that uses  MaxelerNavigationBar and MaxelerToolbar.
* MaxelerViewController - Subclass ofUIViewController with custom layout options, usage message support and Google ad banner.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MaxelerComponents is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MaxelerComponents"
```

## Author

Petar Trifunovic, ptrifunovic@maxeler.com


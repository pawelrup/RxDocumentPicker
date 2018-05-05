# RxDocumentPicker

[![CI Status](https://img.shields.io/travis/pawelrup/RxDocumentPicker.svg?style=flat)](https://travis-ci.org/pawelrup/RxDocumentPicker)
[![Version](https://img.shields.io/cocoapods/v/RxDocumentPicker.svg?style=flat)](https://cocoapods.org/pods/RxDocumentPicker)
[![License](https://img.shields.io/cocoapods/l/RxDocumentPicker.svg?style=flat)](https://cocoapods.org/pods/RxDocumentPicker)
[![Platform](https://img.shields.io/cocoapods/p/RxDocumentPicker.svg?style=flat)](https://cocoapods.org/pods/RxDocumentPicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Xcode 9, Swift 4.1

## Installation

RxDocumentPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxDocumentPicker'
```

## Usage

For iOS versions before iOS 11 you can use `UIDocumentMenuViewController` like below:

```swift
let menu = UIDocumentMenuViewController(documentTypes: [kUTTypePDF as String], in: .import)
menu.rx
	.didPickDocumentPicker
	.do(onNext: { [weak self] (picker: UIDocumentPickerViewController) in
		self?.present(picker, animated: true, completion: nil)
	})
	.flatMap { $0.rx.didPickDocumentAt }
	.subscribe(onNext: {
		print($0)
	})
	.disposed(by: disposeBag)
present(menu, animated: true, completion: nil)
```

`UIDocumentMenuViewController` is deprecated from iOS 11 so you need to use `UIDocumentPickerViewController` directly:

```swift
let picker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
picker.rx
	.didPickDocumentsAt
	.subscribe(onNext: { [weak self] (urls: [URL]) in
        print(urls)
	})
	.disposed(by: disposeBag)
present(picker, animated: true, completion: nil)
```

If you want to know when user cancelled picking documents you can subscribe to `documentPickerWasCancelled` like below:

```swift
let picker = UIDocumentPickerViewController(documentTypes: [kUTTypePDF as String], in: .import)
picker.rx
	.documentPickerWasCancelled
	.subscribe(onNext: {
		// Do something
	})
	.disposed(by: disposeBag)
present(picker, animated: true, completion: nil)
```

You can see usage of `RxDocumentPicker` in example.

## Author

lobocode, pawelrup@lobocode.pl

## License

RxDocumentPicker is available under the MIT license. See the LICENSE file for more info.

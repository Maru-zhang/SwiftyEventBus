# SwiftyEventBus

![](https://img.shields.io/badge/language-swift-orange.svg)
[![CI Status](https://img.shields.io/travis/Maru-zhang/SwiftyEventBus.svg?style=flat)](https://travis-ci.org/Maru-zhang/SwiftyEventBus)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](https://codecov.io/gh/Maru-zhang/SwiftyEventBus/branch/master/graph/badge.svg)](https://codecov.io/gh/Maru-zhang/SwiftyEventBus)
[![Version](https://img.shields.io/cocoapods/v/SwiftyEventBus.svg?style=flat)](https://cocoapods.org/pods/SwiftyEventBus)
[![License](https://img.shields.io/cocoapods/l/SwiftyEventBus.svg?style=flat)](https://cocoapods.org/pods/SwiftyEventBus)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyEventBus.svg?style=flat)](https://cocoapods.org/pods/SwiftyEventBus)

SwiftyEventBus is a publish/subscribe event bus for iOS and Swift.

* simplifies the communication between components
* make your code simple and elegant

## Usage

`SwiftyEventBus` is very easy to use, you just need 3 steps:

#### 1️⃣ **Define**

The stuff that you want to delivery need implement `EventPresentable` Protocol, most of foundation type already implemented, such as `Int`, `Float`, `String`, etc...

If you have custom type, then you should make it confirm `EventPresentable` Protocol.

#### 2️⃣ **Register**

You can register in anywhere, it will always observe until the `EventSubscription` object been released.

```swift
class DemoViewController: UIViewController {

    var ob: EventSubscription<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ob = EventBus.`default`.register { (x: String) in
            print(x)
        }
    }
}
```

#### 3️⃣ **Post**

Finally, you just need to post any type that implement `EventPresentable`.


```swift
EventBus.default.post("Foo")
```

### Rx-Extension

if you project using `RxSwift`, maybe you need this to bridge `SwiftyEventBus` to `Rx`.

```ruby
pod 'SwiftyEventBus/Rx'
```

after that, you can use `SwiftyEventBus` in `RxSwift` world.🎉

```swift
var bag: DisposeBag? = DisposeBag()
EventBus.default.rx.register(String.self)
    .subscribe(onNext: { (x) in
        print(x) /// "foo"
    })
    .disposed(by: bag!)
EventBus.default.post("foo")
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SwiftyEventBus is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftyEventBus'
```

## Author

Maru-zhang, maru-zhang@foxmail.com

## License

SwiftyEventBus is available under the MIT license. See the LICENSE file for more info.



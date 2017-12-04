## ZGIFImage

![image](https://img.shields.io/badge/platform-iOS-yellow.svg)  ![image](https://img.shields.io/badge/support-swift%204%2B-green.svg)  ![image](https://img.shields.io/cocoapods/v/ZGIFImage.svg?style=flat)

Load gif by gif name or Data or URL

![image](https://github.com/MQZHot/ZGIFImage/raw/master/picture.gif)

## How To
```swift
/// example 01
let staticImage = ZGIFImage.image(name: "pic.gif")
topImageView.image = staticImage
/// example 02
let gifImage = ZGIFImage.gif(name: "pic")
imageView.image = gifImage
/// example 03
if let url = URL(string: "http://xxxx.gif") {
    let urlImage = ZGIFImage.image(url: url)
    bottomImageView.image = urlImage
}
```

## Install

* 1.pod 'ZGIFImage'
* 2.pod install / pod update

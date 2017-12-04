## ZGuidePage

![image](https://img.shields.io/badge/platform-iOS-yellow.svg)  ![image](https://img.shields.io/badge/support-swift%204%2B-green.svg)

app引导页，支持静态图片，支持GIF图片，支持视频

自定义pageControl

自定义按钮，添加其他自定义视图

![image](https://github.com/MQZHot/ZGuidePage/raw/master/picture.gif)

## 使用
```swift
// 便利构造方法 - 图片
/// - Parameter imageNamesGroup: 图片名数组
/// - Parameter delegate: ZGuidePageImageCustomized
/// - Parameter showNewVersion: 是否版本更新时显示
public convenience init?(frame: CGRect, imageNamesGroup: [String], delegate: ZGuidePageImageCustomized, showNewVersion: Bool = false)
/// 便利构造方法 - 视频
/// - Parameter videoName: 视频名
/// - Parameter delegate: ZGuidePageVideoCustomized
/// - Parameter showNewVersion: 是否版本更新时显示
public convenience init?(frame: CGRect, videoName: String, delegate: ZGuidePageVideoCustomized, showNewVersion: Bool = false)
```
### ZGuidePageImageCustomized
```swift
/// 自定义pageControl
func guidePageCustomizedPageControl(_ pageControl: ZPageControl)
/// 自定义进入按钮，返回值为添加的页面，其中`pageIndex(Int)`时填在在最后一页，与Int无关
func guidePageCustomizedEnterButton(_ enterButton: UIButton) -> ZGuidePageImagePosition
/// 添加其他自定义的view， 返回元组（view, 位置）
func guidePageCustomizedViews() -> [(UIView, ZGuidePageImagePosition)]?
```
### ZGuidePageVideoCustomized
```swift
/// 自定义进入按钮
func guidePageCustomizedEnterButton(enterButton: UIButton)->Void
/// 添加其他自定义的view， 返回元组（view, 位置）
func guidePageCustomizedViews() -> [UIView]?
```

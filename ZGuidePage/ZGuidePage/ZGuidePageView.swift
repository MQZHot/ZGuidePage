//
//  ZGuidePageView.swift
//  ZGuidePage
//
//  Created by mengqingzheng on 2017/12/2.
//  Copyright © 2017年 MQZHot. All rights reserved.
//

import UIKit
import ZGIFImage
import ZPageControl
import AVFoundation

/// 图片代理
public protocol ZGuidePageImageCustomized {
    /// 自定义pageControl
    func guidePageCustomizedPageControl(_ pageControl: ZPageControl)
    /// 自定义进入按钮，返回值为添加的页面，其中`pageIndex(Int)`时填在在最后一页，与Int无关
    func guidePageCustomizedEnterButton(_ enterButton: UIButton) -> ZGuidePageImagePosition
    /// 添加其他自定义的view， 返回元组（view, 位置）
    func guidePageCustomizedViews() -> [(UIView, ZGuidePageImagePosition)]?
}
extension ZGuidePageImageCustomized {
    func guidePageCustomizedPageControl(_ pageControl: ZPageControl) {}
    func guidePageCustomizedViews() -> [(UIView, ZGuidePageImagePosition)]? { return nil }
}
/// 自定义view显示枚举， `always`为每页显示，`pageIndex(Int)`下标页数显示
public enum ZGuidePageImagePosition {
    case always
    case pageIndex(Int)
}
/// video代理
public protocol ZGuidePageVideoCustomized {
    /// 自定义进入按钮
    func guidePageCustomizedEnterButton(enterButton: UIButton)->Void
    /// 添加其他自定义的view， 返回元组（view, 位置）
    func guidePageCustomizedViews() -> [UIView]?
}
extension ZGuidePageVideoCustomized {
    func guidePageCustomizedViews() -> [UIView]? { return nil }
}
public class ZGuidePageView: UIView {
    /// 便利构造方法 - 图片
    /// - Parameter imageNamesGroup: 图片名数组
    /// - Parameter delegate: ZGuidePageImageCustomized
    /// - Parameter showNewVersion: 是否版本更新时显示
    public convenience init?(frame: CGRect, imageNamesGroup: [String], delegate: ZGuidePageImageCustomized, showNewVersion: Bool = false) {
        if imageNamesGroup.count == 0 { return nil }
        self.init(frame: frame, showNewVersion: showNewVersion)
        self.delegate = delegate
        let width = frame.size.width
        let height = frame.size.height
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: width*CGFloat(imageNamesGroup.count), height: height)
        addSubview(scrollView)
        for i in 0..<imageNamesGroup.count {
            let imgViewFrame = CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height)
            let imageView = UIImageView(frame: imgViewFrame)
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            let imageName = imageNamesGroup[i]
            if imageName.contains(".gif") {
                imageView.image = ZGIFImage.gif(name: imageName)
            } else {
                imageView.image = ZGIFImage.image(name: imageName)
            }
            imageViews.append(imageView)
        }
        setupPageControl(imageNamesGroup.count)
        delegate.guidePageCustomizedPageControl(pageControl)
        let position = delegate.guidePageCustomizedEnterButton(enterButton)
        switch position {
        case .always:
            addSubview(enterButton)
        default:
            let imageView = imageViews.last
            imageView?.addSubview(enterButton)
        }
        if let views = delegate.guidePageCustomizedViews() {
            for (view, position) in views {
                switch position {
                case .pageIndex(let index):
                    let imageView = imageViews[index]
                    imageView.addSubview(view)
                default: addSubview(view)
                }
            }
        }
    }
    /// 便利构造方法 - 视频
    /// - Parameter videoName: 视频名
    /// - Parameter delegate: ZGuidePageVideoCustomized
    /// - Parameter showNewVersion: 是否版本更新时显示
    public convenience init?(frame: CGRect, videoName: String, delegate: ZGuidePageVideoCustomized, showNewVersion: Bool = false) {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: nil) else { return nil }
        self.init(frame: frame, showNewVersion: showNewVersion)
        self.videoDelegate = delegate
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.contentsScale = UIScreen.main.scale
        playerLayer.frame = frame
        layer.addSublayer(playerLayer)
        player.play()
        delegate.guidePageCustomizedEnterButton(enterButton: enterButton)
        addSubview(enterButton)
        if let views = videoDelegate.guidePageCustomizedViews() {
            for view in views {
                addSubview(view)
            }
        }
    }
    
    fileprivate var delegate: ZGuidePageImageCustomized!
    fileprivate var videoDelegate: ZGuidePageVideoCustomized!
    fileprivate lazy var enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(enterButtonEvent), for: .touchUpInside)
        return button
    }()
    fileprivate var imageViews = [UIImageView]()
    fileprivate var pageControl: ZPageControl!
    
    init?(frame: CGRect, showNewVersion: Bool = false) {
        guard let info = Bundle.main.infoDictionary,
            let newVersion = info["CFBundleShortVersionString"] as? String else { return nil }
        let oldVersion = UserDefaults.standard.string(forKey: "ZGuidePage-version")
        if (showNewVersion && newVersion == oldVersion) || oldVersion != nil {
            return nil
        } else {
            UserDefaults.standard.set(newVersion, forKey: "ZGuidePage-version")
        }
        super.init(frame: frame)
    }
    fileprivate func setupPageControl(_ numberOfPages: Int) {
        pageControl = ZPageControl(frame: CGRect(x: 0, y: frame.size.height-50, width: bounds.size.width, height: 50))
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = 0
        addSubview(pageControl)
    }
    @objc fileprivate func enterButtonEvent() {
        removeFromSuperview()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit { print("dealloc") }
}

extension ZGuidePageView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/frame.size.width)
    }
}

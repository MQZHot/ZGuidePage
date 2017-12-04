//
//  ViewController.swift
//  ZGuidePage
//
//  Created by mengqingzheng on 2017/12/2.
//  Copyright © 2017年 MQZHot. All rights reserved.
//

import UIKit
import ZPageControl

let screen_w = UIScreen.main.bounds.size.width
let screen_h = UIScreen.main.bounds.size.height

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setGifGuidePage()
//        setVideoGuidePage()
    }
}

extension ViewController: ZGuidePageImageCustomized {
    func setGifGuidePage() {
        let imageNamesGroup = ["gif-1.gif","gif-2.gif","gif-3.gif"]
        if let guideView = ZGuidePageView(frame: UIScreen.main.bounds, imageNamesGroup: imageNamesGroup, delegate: self, showNewVersion: false) {
            navigationController?.view.addSubview(guideView)
        }
    }
    func guidePageCustomizedEnterButton(_ enterButton: UIButton) -> ZGuidePageImagePosition {
        enterButton.frame = CGRect(x: 0, y: 0 , width: 100, height: 50)
        enterButton.center = CGPoint(x: screen_w/2, y: screen_h-100)
        enterButton.backgroundColor = UIColor.red
        enterButton.setTitle("进入应用", for: .normal)
        return .pageIndex(0)
    }
    func guidePageCustomizedPageControl(_ pageControl: ZPageControl) {
        pageControl.isHidden = true
    }
    func guidePageCustomizedViews() -> [(UIView, ZGuidePageImagePosition)]? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = "SD卡焦点科技答复"
        return [(label, .pageIndex(0))]
    }
}

/// 视频
extension ViewController: ZGuidePageVideoCustomized {
    func setVideoGuidePage() {
        if let guideView = ZGuidePageView(frame: UIScreen.main.bounds, videoName: "guideMovie1.mov", delegate: self, showNewVersion: true) {
            navigationController?.view.addSubview(guideView)
        }
    }
    
    func guidePageCustomizedEnterButton(enterButton: UIButton) {
        enterButton.frame = CGRect(x: 0, y: 0 , width: 100, height: 50)
        enterButton.center = CGPoint(x: screen_w/2, y: screen_h-100)
        enterButton.backgroundColor = UIColor.red
        enterButton.setTitle("进入应用", for: .normal)
    }
    
    func guidePageCustomizedViews() -> [UIView]? {
        let button = UIButton(type: .custom)
        button.setTitle("跳过", for: .normal)
        button.frame = CGRect(x: screen_w-100, y: 60 , width: 70, height: 35)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.red, for: .normal)
        return [button]
    }
}

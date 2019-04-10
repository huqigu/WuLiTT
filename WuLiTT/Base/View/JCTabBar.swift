//
//  JCTabBar.swift
//  WuLiTT
//
//  Created by yellow on 2019/4/10.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

@objc protocol JCTabBarDelegate {
    func tabBarDidSelectedIndex(index: Int)
}

class JCTabBar: UIView {
    let tabbarButtons = NSMutableArray()

    var selectedBtn = JCTabBarButton()

    weak var delegate: JCTabBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let line = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 1))
        line.backgroundColor = UIColor.gray
        line.alpha = 0.3
        addSubview(line)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 添加按钮

extension JCTabBar {
    func addTabBarButtonWithItem(item: UITabBarItem) {
        let tabBarButton = JCTabBarButton()

        tabBarButton.setTitle(item.title, for: .normal)
        tabBarButton.setTitle(item.title, for: .selected)

        tabBarButton.setImage(item.image, for: .normal)
        tabBarButton.setImage(item.selectedImage, for: .selected)

        tabbarButtons.add(tabBarButton)
        addSubview(tabBarButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let h = frame.size.height
        let w = frame.size.width

        let buttonH = h
        let buttonW = w / CGFloat(tabbarButtons.count)
        let buttonY = 0

        for index in 0 ... tabbarButtons.count - 1 {
            let button: JCTabBarButton = tabbarButtons[index] as! JCTabBarButton
            let buttonX = CGFloat(index) * buttonW

            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: buttonH)

            button.tag = index

            if index == 0 {
                selectedBtn = button
                selectedBtn.isSelected = true
            }

            weak var weakself = self
            button.rx.tap.subscribe(onNext: {
                weakself!.selectedBtn.isSelected = false
                button.isSelected = true
                weakself!.selectedBtn = button

                weakself!.delegate?.tabBarDidSelectedIndex(index: button.tag)

            }).disposed(by: disposeBag)
        }
    }
}

// MARK: Public Methods

extension JCTabBar {
    func refreshAnimation() {
        let button = tabbarButtons[0] as! JCTabBarButton

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0) // 旋转角度
        rotationAnimation.duration = 0.6 // 旋转周期
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = MAXFLOAT // 旋转次数
        button.imageView?.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }

    func removeAnimation() {
        let button = tabbarButtons[0] as! JCTabBarButton
        button.imageView?.layer.removeAllAnimations()
    }
}

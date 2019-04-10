//
//  JCTabBarButton.swift
//  WuLiTT
//
//  Created by yellow on 2019/4/10.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCTabBarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        set {}
        get {
            return false
        }
    }
}

extension JCTabBarButton {
    func setUpSubViews() {
        imageView!.contentMode = UIViewContentMode.center
        titleLabel!.textAlignment = NSTextAlignment.center
        titleLabel!.font = UIFont.systemFont(ofSize: 11)
        setTitleColor(UIColor.black, for: UIControlState.normal)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let btnW: CGFloat = frame.size.width
        let btnH: CGFloat = frame.size.height

        imageView!.frame = CGRect(x: 0.0, y: 0.1 * btnH, width: btnW, height: 0.5 * btnH)
        titleLabel!.frame = CGRect(x: 0.0, y: imageView!.frame.maxY + 0.1 * btnH, width: btnW, height: 0.3 * btnH)
    }
}

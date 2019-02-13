//
//  HomeNavigationView.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit
class HomeNavigationView: UIView {
    lazy var newsBtn = { () -> UIButton in

        createBtn(title: "头条")
    }()

    lazy var videoBtn = { () -> UIButton in

        createBtn(title: "视频")
    }()

    let animationView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpSubViews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 设置UI界面

extension HomeNavigationView {
    func setUpSubViews() {
        addSubview(newsBtn)
        addSubview(videoBtn)

        // 1. 顶部按钮
        newsBtn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.left.equalTo((kScreenW - 80) / 3.0)
        }

        videoBtn.snp.makeConstraints { make in
            make.width.equalTo(newsBtn.snp.width)
            make.height.equalTo(newsBtn.snp.height)
            make.bottom.equalTo(newsBtn.snp.bottom)
            make.right.equalTo((kScreenW - 80) / 3.0 * -1)
        }

        // 2. 黄色移动下划线
        addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(2)
            make.bottom.equalTo(newsBtn.snp.bottom).offset(3)
            make.centerX.equalTo(newsBtn.snp.centerX)
        }
        animationView.backgroundColor = yellowColor

        // 3.底部分割线
        let line = UIView()
        line.backgroundColor = UIColor.gray
        addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
}

// MARK: 初始化按钮

extension HomeNavigationView {
    func createBtn(title: String) -> UIButton {
        let btn = UIButton()

        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.titleLabel?.textAlignment = .center
        btn.setTitle(title, for: .normal)

        btn.rx.tap.subscribe(onNext: {
            UIView.animate(withDuration: 0.25, animations: {
                self.animationView.center = CGPoint(x: btn.center.x, y: self.animationView.center.y)
            })
        }).disposed(by: disposeBag)

        return btn
    }
}

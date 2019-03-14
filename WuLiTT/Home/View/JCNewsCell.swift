//
//  JCNewsCell.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/14.
//  Copyright © 2019 yellow. All rights reserved.
//

import SnapKit
import UIKit

class JCNewsCell: UITableViewCell {
    var titleLabel: UILabel?
    var mImageView: UIImageView?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        mImageView = UIImageView()
        contentView.addSubview(mImageView!)
        mImageView?.snp.makeConstraints({ make in
            make.width.equalTo(120)
            make.height.equalTo(80)
            make.top.equalTo(10)
            make.right.bottom.equalTo(-10)
        })
        mImageView?.contentMode = .scaleAspectFit

        titleLabel = UILabel()
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ make in
            make.left.top.equalTo(10)
            make.right.equalTo((mImageView?.snp.left)!).offset(-10)
        })
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

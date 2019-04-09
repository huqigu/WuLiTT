//
//  JCNewsSingleImageCell.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/26.
//  Copyright © 2019 yellow. All rights reserved.
//

import SnapKit
import UIKit

class JCNewsSingleImageCell: UITableViewCell {
    var titleLabel: UILabel?
    var mImageView: UIImageView?

    var newsModel: JCNewsModel? {
        didSet {
            self.titleLabel?.text = newsModel!.title
            if (newsModel!.newsImageList?.count)! > 0 {
                let newsImageModel: JCNewsImageModel = newsModel!.newsImageList![0]
                let url = URL(string: newsImageModel.url!)
                self.mImageView?.kf.setImage(with: url)
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginL = 15.0

        mImageView = UIImageView()
        contentView.addSubview(mImageView!)
        mImageView?.snp.makeConstraints({ make in
            make.width.equalTo(120)
            make.height.equalTo(80)
            make.top.equalTo(marginL)
            make.right.bottom.equalTo(marginL * -1.0)
        })
        mImageView?.contentMode = .scaleAspectFill
        mImageView?.layer.masksToBounds = true

        titleLabel = UILabel()
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ make in
            make.left.top.equalTo(marginL)
            make.right.equalTo((mImageView?.snp.left)!).offset(marginL * -1.0)
        })
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0

        selectionStyle = .none
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

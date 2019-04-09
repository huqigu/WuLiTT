//
//  JCNewsThreeImageCell.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/26.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit

class JCNewsThreeImageCell: UITableViewCell {
    var titleLabel: UILabel?
    var mImageView1: UIImageView?
    var mImageView2: UIImageView?
    var mImageView3: UIImageView?

    var newsModel: JCNewsModel? {
        didSet {
            self.titleLabel?.text = newsModel!.title

            let newsImageModel1: JCNewsImageModel = newsModel!.newsImageList![0]
            let url1 = URL(string: newsImageModel1.url!)
            self.mImageView1?.kf.setImage(with: url1)

            let newsImageModel2: JCNewsImageModel = newsModel!.newsImageList![1]
            let url2 = URL(string: newsImageModel2.url!)
            self.mImageView2?.kf.setImage(with: url2)

            let newsImageModel3: JCNewsImageModel = newsModel!.newsImageList![2]
            let url3 = URL(string: newsImageModel3.url!)
            self.mImageView3?.kf.setImage(with: url3)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ make in
            make.left.top.equalTo(15)
            make.centerX.equalTo(self)
        })
        titleLabel?.textColor = UIColor.black
        titleLabel?.numberOfLines = 0

        let marginX = 5.0
        let marginL = 15.0
        let imageW = (Float(kScreenW) - Float(2.0 * marginX) - Float(2.0 * marginL)) / 3
        let imageH = 80

        mImageView1 = UIImageView()
        contentView.addSubview(mImageView1!)
        mImageView1?.snp.makeConstraints({ make in
            make.width.equalTo(imageW)
            make.height.equalTo(imageH)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(marginX)
            make.left.equalTo(marginL)
            make.bottom.equalTo(marginL * -1.0)
        })
        mImageView1?.contentMode = .scaleAspectFill
        mImageView1?.layer.masksToBounds = true

        mImageView2 = UIImageView()
        contentView.addSubview(mImageView2!)
        mImageView2?.snp.makeConstraints({ make in
            make.width.equalTo(imageW)
            make.height.equalTo(imageH)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(marginX)
            make.left.equalTo((mImageView1?.snp.right)!).offset(marginX)
        })
        mImageView2?.contentMode = .scaleAspectFill
        mImageView2?.layer.masksToBounds = true

        mImageView3 = UIImageView()
        contentView.addSubview(mImageView3!)
        mImageView3?.snp.makeConstraints({ make in
            make.width.equalTo(imageW)
            make.height.equalTo(imageH)
            make.top.equalTo((titleLabel?.snp.bottom)!).offset(marginX)
            make.left.equalTo((mImageView2?.snp.right)!).offset(marginX)
        })
        mImageView3?.contentMode = .scaleAspectFill
        mImageView3?.layer.masksToBounds = true

        selectionStyle = .none
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

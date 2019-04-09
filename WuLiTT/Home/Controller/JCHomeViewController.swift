//
//  JCHomeViewController.swift
//  唔哩头条
//
//  Created by yellow on 2019/1/2.
//  Copyright © 2019 yellow. All rights reserved.
//

import MJRefresh
import Moya
import RxSwift
import UIKit

class JCHomeViewController: JCViewController {
    let viewModel = JCNewsViewModel()

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true

        let navigationBar = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNavigationBarHeight))

        view.addSubview(navigationBar)

        tableView = UITableView(frame: CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: kScreenH - kNavigationBarHeight - kBottomSafeHeight), style: UITableViewStyle.plain)

//        tableView.register(JCNewsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(JCNewsSingleImageCell.self, forCellReuseIdentifier: singleImageCellId)
        tableView.register(JCNewsThreeImageCell.self, forCellReuseIdentifier: threeImageCellId)

        tableView.estimatedRowHeight = 120

        tableView.tableFooterView = UIView()

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior(rawValue: 2)!
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        view.addSubview(tableView)

        viewModel.tableView = tableView

        viewModel.SetConfig()

        weak var weakself = self

        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            weakself?.viewModel.requestNewDataCommond.onNext(true)
        })

        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            weakself?.viewModel.requestNewDataCommond.onNext(false)
        })

        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("选中项的indexPath为：\(indexPath)")
        }).disposed(by: disposeBag)

        tableView.mj_header.beginRefreshing()
    }
}

//
//  JCNewsViewModel.swift
//  WuLiTT
//
//  Created by yellow on 2019/3/14.
//  Copyright © 2019 yellow. All rights reserved.
//

import Alamofire
import Kingfisher
import MJRefresh
import Moya
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

let cellId = "JCNewsCellId"

let singleImageCellId = "JCNewsSingleImageCell"
let threeImageCellId = "JCNewsThreeImageCell"

enum JCRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class JCNewsViewModel: NSObject {
    var bag: DisposeBag = DisposeBag()

    let requestMessageList = PublishSubject<Bool>()

//    var modelObserable = Variable<[JCNewsModel]>([])

    var modelObserable = Variable<[SectionModel<String, JCNewsModel>]>([])

    var refreshStateObserable = Variable<JCRefreshStatus>(.none)

    let requestNewDataCommond = PublishSubject<Bool>()

    var pageIndex = Int()

    var tableView = UITableView()

    func SetConfig() {
        // 绑定tableView
        // 单个cell时
//        modelObserable.asObservable().bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: JCNewsCell.self)) { _, model, cell in
//
//            cell.titleLabel?.text = model.title
//
//            if (model.newsImageList!.count) != 0 {
//                let newsImageModel: JCNewsImageModel = model.newsImageList![0]
//                let url = URL(string: newsImageModel.url!)
//                cell.mImageView?.kf.setImage(with: url)
//            }
//
//        }.disposed(by: bag)

        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, JCNewsModel>>(configureCell: { (_, tv, indexPath, newsModel) -> UITableViewCell in

            if (newsModel.newsImageList?.count)! <= 2 {
                let cell = tv.dequeueReusableCell(withIdentifier: singleImageCellId, for: indexPath) as! JCNewsSingleImageCell

                cell.newsModel = newsModel

                return cell
            } else {
                let cell = tv.dequeueReusableCell(withIdentifier: threeImageCellId, for: indexPath) as! JCNewsThreeImageCell

                cell.newsModel = newsModel

                return cell
            }
        })

        modelObserable.asObservable().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
        // 请求数据
        requestNewDataCommond.subscribe { (event: Event<Bool>) in

            if event.element! { // 刷新
                provider.requestModelList(.getHomeList(channelId: 30, timestamp: self.getCurrentTimes(), slipType: "DOWN"), JCNewsModel.self).subscribe(onSuccess: { modelList in

                    self.modelObserable.value = [SectionModel(model: "", items: modelList)]
                    self.refreshStateObserable.value = .endHeaderRefresh

                }, onError: { _ in

                    self.refreshStateObserable.value = .endHeaderRefresh

                }).disposed(by: self.bag)

            } else { // 加载更多
                provider.requestModelList(.getHomeList(channelId: 30, timestamp: self.getCurrentTimes(), slipType: "UP"), JCNewsModel.self).subscribe(onSuccess: { modelList in

                    self.modelObserable.value.append(SectionModel(model: "", items: modelList))

//                    self.modelObserable.value += modelList
                    self.refreshStateObserable.value = .endFooterRefresh

                }, onError: { _ in

                    self.refreshStateObserable.value = .endFooterRefresh

                }).disposed(by: self.bag)
            }
        }.disposed(by: bag)

        // 刷新状态
        refreshStateObserable.asObservable().subscribe(onNext: { state in
            switch state {
            case .beginHeaderRefresh:
                self.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.resetNoMoreData()
            case .beginFooterRefresh:
                self.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: bag)
    }

    // 获取时间戳
    func getCurrentTimes() -> Int {
        // 获取当前时间
        let now = NSDate()

        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"

        // 当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return Int(timeInterval * 1000)
    }
}

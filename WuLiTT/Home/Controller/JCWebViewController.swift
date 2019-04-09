//
//  JCWebViewController.swift
//  WuLiTT
//
//  Created by yellow on 2019/4/9.
//  Copyright © 2019 yellow. All rights reserved.
//

import UIKit
import WebKit

class JCWebViewController: UIViewController, WKUIDelegate {
    var webView = WKWebView()

    var progressView = UIProgressView()

    let configuration = WKWebViewConfiguration()

    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        initWebView()
        webView.load(URLRequest(url: URL(string: urlString)!))
    }

    func initWebView() {
        configuration.userContentController = WKUserContentController()
        configuration.preferences = WKPreferences()
        configuration.allowsInlineMediaPlayback = true

        webView = WKWebView(frame: CGRect(x: 0, y: kNavigationBarHeight, width: kScreenW, height: kScreenH - kNavigationBarHeight), configuration: configuration)
        view.addSubview(webView)
        webView.uiDelegate = self as WKUIDelegate

        _ = webView.rx.observe(Float.self, "estimatedProgress")
            .subscribe({ [weak self] _ in
                self!.progressView.setProgress(Float(self!.webView.estimatedProgress), animated: true)
                if self!.webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        self!.progressView.progress = 0.0
                    }) { _ in
                        self?.progressView.progress = 0.0
                    }
                }
            }).disposed(by: disposeBag)

        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 2.0))
        progressView.backgroundColor = UIColor.clear
        progressView.trackTintColor = UIColor.clear
        progressView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        webView.addSubview(progressView)
    }

    deinit {
        print(#file, #function)
    }
}

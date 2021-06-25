//
//  QuizletInstructionsViewController.swift
//  Design
//
//  Created by 65,115,114,105,116,104,98 on 9/9/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import WebKit
import GoogleMobileAds

class QuizletInstructionsViewController: UIViewController, WKNavigationDelegate {
    let defaults = UserDefaults(suiteName: "group.com.Tonnelier.Lofee")

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var webView: WKWebView!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
             webView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(webView)
        webView.navigationDelegate = self
        let url = URL(string: "https://www.youtube.com/watch?v=hID0A0BCG-E&feature=youtu.be")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        if defaults?.bool(forKey: "premium") == false{
            bannerView.rootViewController = self
            bannerView.adUnitID = "ca-app-pub-1093493132842059~4613068867"
            bannerView.load(GADRequest())
        }
    }
    
}

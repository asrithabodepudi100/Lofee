//
//  AboutUsContactViewController.swift
//  Lofee
//
//  Created by 65,115,114,105,116,104,98 on 10/6/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import Lottie
import WebKit

class AboutUsContactViewController: UIViewController, WKNavigationDelegate { 

  
    @IBOutlet weak var webView: WKWebView!
    private var animationView: AnimationView?

    override func viewDidLoad() {

      super.viewDidLoad()
      animationView = .init(name: "load")
      animationView!.frame = view.bounds
      animationView!.contentMode = .scaleAspectFit
      animationView!.loopMode = .loop
      animationView!.animationSpeed = 0.75
      view.addSubview(animationView!)
      animationView!.play()
        
        let url = URL(string: "https://tonnelier.tech")!
        

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self

    }

    
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print ("HIHIHI")
        animationView?.isHidden = true

    }
}


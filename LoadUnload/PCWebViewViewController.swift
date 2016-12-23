//
//  PCWebViewViewController.swift
//  LoadUnload
//
//  Created by Admin on 23/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit
import PKHUD
struct PCWeb{
    var title: String!
    var url: String!
    
}

class PCWebViewViewController: UIViewController, UIWebViewDelegate {
    var pcweb: PCWeb?
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = pcweb?.title ?? ""
        let url =  pcweb?.url
        webView.delegate = self
        webView.loadRequest(URLRequest.init(url: URL.init(string: url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
        HUD.show(.label("Loading... Please Wait..."))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        HUD.hide()
    }
}

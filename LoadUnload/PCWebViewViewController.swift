//
//  PCWebViewViewController.swift
//  LoadUnload
//
//  Created by Admin on 23/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class PCWebViewViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = "Rate Card"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

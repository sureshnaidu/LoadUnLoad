//
//  RateCardViewController.swift
//  LoadUnload
//
//  Created by Admin on 09/01/17.
//  Copyright © 2017 FreeLancer. All rights reserved.
//

import UIKit

class RateCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        view.isOpaque = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: false , completion: nil)
    }


}

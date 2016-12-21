//
//  BookingHostoryViewController.swift
//  LoadUnload
//
//  Created by Admin on 21/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class BookingHostoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "bookingHistory")
        
        // Adding the right informations
        //        cell.imageView?.image = UIImage(named: "source")
        cell.textLabel?.text = "343"
        cell.textLabel?.textColor = UIColor.gray //UIColorFromRGB(rgbValue: 0xededed)
        
        // Returning the cell
        return cell
    }
    
    
}

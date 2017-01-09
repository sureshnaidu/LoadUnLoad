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
        
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = "Booking History"

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell", for: indexPath) as! BookingHistoryTableViewCell

        cell.confirmTitleLabel.text = "CONFIRMED"
        cell.dataLabel.text = "Wed Oct 12 5:54 AM 2016"
        cell.bookingIdLabel.text = "BK0000000444"
        cell.fromAdderessLAbel.text = " sadfsdaf asdf asdf asdf asdf asdfas dfa sdfasdf asdfasdfa sdfas dfa sdfasd"
        cell.toAddressLabel.text = "a sdfsdf asdf asdf asdfas dfk ajsdhfkjas kas dhfaks djfhasdk jfhasdsdf asdfasd"
        
        // Returning the cell
        return cell
    }
    
    
}

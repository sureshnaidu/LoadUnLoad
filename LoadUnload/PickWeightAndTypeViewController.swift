//
//  PickWeightAndTypeViewController.swift
//  LoadUnload
//
//  Created by Admin on 29/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class PickWeightAndTypeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,UITextFieldDelegate {

    @IBOutlet var wightView: UIView!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var weightTextField: UITextField!
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "selectionCell")
        
        cell.textLabel?.text = "sss"
        cell.textLabel?.textColor = UIColor.gray
        // Returning the cell
        return cell
    }
    @IBAction func okButtonClicked(_ sender: UIButton) {
        
        weightTextField.resignFirstResponder()
        wightView.isHidden = true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        
        self.bottomConstraint.constant = 216
        self.view.layoutIfNeeded()
        
        return true
        
    }

}

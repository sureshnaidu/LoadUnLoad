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
    
    var titlesArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        view.isOpaque = true
        // Do any additional setup after loading the view.
        
        titlesArray = ["HouseShifting", "Home Appliances/Electronics", "Poultry/Agro","Industrial","Medical","Liquid","Fragile","Construction","Others"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "selectionCell")
        cell.textLabel?.text = titlesArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.imageView?.image = UIImage(named : "logout")
        // Returning the cell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath as IndexPath)! as UITableViewCell
        currentCell.contentView.backgroundColor = UIColorFromRGB(rgbValue: UInt(Constants.YELLOW_THEME_COLOR))
    
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

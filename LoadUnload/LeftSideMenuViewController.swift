//
//  LeftSideMenuViewController.swift
//  LoadUnload
//
//  Created by Admin on 21/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit
import Material
class LeftSideMenuViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    var elementsArray: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        elementsArray = ["Book your truck","Booking history", "Rate card" , "Corporate profile", "Emergency contacts","Support" , "About" , "Logout"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        cell.imageView?.image = UIImage(named: "source")
        cell.textLabel?.text = self.elementsArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray //UIColorFromRGB(rgbValue: 0xededed)
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rootView : UIViewController
        
        if indexPath.row == 0  {
            rootView =  UIStoryboard.viewController(identifier: "ViewController") as! ViewController

        }
        else{
            rootView =  UIStoryboard.viewController(identifier: "BookingHostoryViewController") as! BookingHostoryViewController
        }
        (navigationDrawerController?.rootViewController as? ToolbarController)?.transition(to: rootView, completion: closeNavigationDrawer)
        
    }
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
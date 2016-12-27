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
    
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var elementsArray: Array<String> = []
     var imagesArray: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = UserSession.user()?.name ?? ""
        phoneLabel.text = UserSession.user()?.mobileNo ?? ""
        elementsArray = ["Book your truck","Booking history", "Rate card" , "Corporate profile", "Emergency contacts","Support" , "About" , "Logout"]
        imagesArray =  ["ic_nav_my_rides","ic_nav_my_rides","ic_nav_rate_card","ic_office_favourite","ic_nav_emergency_contact","ic_nav_support","about","logout"]
        listenNotifications()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listenNotifications(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "AppNavigationDrawerControllerOPEN"), object: nil, queue: nil) { (notification) in
            self.nameLabel.text = UserSession.user()?.name ?? ""
            self.phoneLabel.text = UserSession.user()?.mobileNo ?? ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        let imageName = self.imagesArray[indexPath.row]
        cell.imageView?.image = UIImage(named:imageName)
        cell.textLabel?.text = self.elementsArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.gray //UIColorFromRGB(rgbValue: 0xededed)
        // Returning the cell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
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
        else if indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 6{
            rootView =  UIStoryboard.viewController(identifier: "PCWebViewViewController") as! PCWebViewViewController
            switch indexPath.row {
            case 2:
                (rootView as! PCWebViewViewController).pcweb = PCWeb.init(title: "Rate Card",url: "http://ragsarma-001-site6.htempurl.com/ratecard/mobile")
                break
            case 5:
                (rootView as! PCWebViewViewController).pcweb = PCWeb.init(title: "Support",url: "http://ragsarma-001-site6.htempurl.com/Help/menu")
                break
            case 6:
                (rootView as! PCWebViewViewController).pcweb = PCWeb.init(title: "About",url: "http://ragsarma-001-site6.htempurl.com/Help/menu")
                break
            default:
                break
            }
            closeNavigationDrawer(result: true)
        }
        else if indexPath.row == 7{
            UserSession.logout()
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

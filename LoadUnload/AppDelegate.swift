//
//  AppDelegate.swift
//  LoadUnload
//
//  Created by Admin on 13/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //AIzaSyB2ln4B_uA5z1dvWn5WwoBd_LtKqePQLI4
       
        GMSServices.provideAPIKey("AIzaSyB2ln4B_uA5z1dvWn5WwoBd_LtKqePQLI4")
        GMSPlacesClient.provideAPIKey("AIzaSyBLi8S99bjOzbmlR69DCvGxThJHtXGEeYQ")
        
        let rootViewController: ViewController = {
            return UIStoryboard.viewController(identifier: "ViewController") as! ViewController
        }()
     
        let leftViewController: LeftSideMenuViewController = {
            return UIStoryboard.viewController(identifier: "LeftSideMenuViewController") as! LeftSideMenuViewController
        }()
        
//        window = UIWindow(frame: Screen.bounds)
//        window!.rootViewController = AppNavigationDrawerController(rootViewController: rootViewController,
//                                                                   leftViewController: leftViewController)
//        window!.makeKeyAndVisible()

        
        let appToolbarController = AppToolbarController(rootViewController: rootViewController)
        window = UIWindow(frame: Screen.bounds)
        window!.rootViewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: leftViewController)
        window!.makeKeyAndVisible()
        
          UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension UIStoryboard {
    class func viewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}


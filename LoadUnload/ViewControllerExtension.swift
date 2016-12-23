//
//  ViewControllerExtension.swift
//  LoadUnload
//
//  Created by Narendra Kumar Rangisetty on 12/23/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    func alert(title: String = "Error", message: String = "", action:String = "OK") {
        DispatchQueue.main.async {
            let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction.init(title: action, style: .default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
}


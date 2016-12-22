//
//  LogInViewController.swift
//  LoadUnload
//
//  Created by Admin on 15/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var scroolView: UIScrollView!
       var activeField: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        phoneNumber.text = "8019230706"
        password.text = "vijay"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWasShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(_ notification: Notification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height+15.0, 0.0)
        
        self.scroolView.contentInset = contentInsets
        self.scroolView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if activeField != nil {
            if (!aRect.contains(activeField!.frame.origin))
            {
                self.scroolView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,-keyboardSize!.height+keyboardSize!.height, 0.0)
        self.scroolView.contentInset = contentInsets
        self.scroolView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
    }

    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumber {
           password.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        
        return true
    }
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        
        if let phone  = phoneNumber.text , let password = password.text {
            let payload = ["MobileNo":phone, "Password": password]
            
            
            NetworkInterface.fetchJSON(.login, headers: [:], params: [:], payload: payload, requestCompletionHander: { (success,data, response, error) -> (Void) in
                if success, let token = data?["token"] as? String {
                    UserSession.shared.token = token
                    UserSession.shared.mobileNo = phone
                    UserSession.save()
                    self.customerInfo()
                    
                }else{
                    
                }
            })
        }
    }
    
    func customerInfo(){
        NetworkInterface.fetchJSON(.customerInfo, headers: [:], params: ["mobile":UserSession.user()!.mobileNo!]) { (success, data, response, error) -> (Void) in
            if success == true, data?["MobileNo"] != nil {
                UserSession.shared.emailID = data?["EmailID"] as? String
                UserSession.shared.mobileNo = data?["MobileNo"] as? String
                UserSession.shared.name = data?["Name"] as? String
                UserSession.save()
                DispatchQueue.main.async {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }else{
                
            }
        }
    }
}

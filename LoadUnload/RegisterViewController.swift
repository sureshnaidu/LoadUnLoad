//
//  RegisterViewController.swift
//  LoadUnload
//
//  Created by Admin on 14/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var phoneNum: UITextField!
    @IBOutlet weak var scroolView: UIScrollView!
    @IBOutlet var emailId: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var reenterPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Mark: Manage content when keyboard pops up
    var activeField: UITextField?
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    @IBAction func signUpClicked(_ sender: Any) {
        
        if (self.userName.text?.characters.count == 0) , (self.phoneNum.text?.characters.count == 0) , (self.emailId.text?.characters.count == 0) , (self.password.text?.characters.count == 0) , (self.reenterPassword.text?.characters.count == 0) {
            self.showErrorAlert("Error", message: "Please enter All Fields")
            return
        }
        else if (isValidEmail(testStr: self.emailId.text!) != true) {
            self.showErrorAlert("Email Input Error", message: "Please make sure you have entered a valid email.")
        }
        else if(self.phoneNum.text?.characters.count != 10) {
            self.showErrorAlert("Phone Input Error", message: "Please make sure you have entered a valid phone number. Phone numbers should be 10 digits.")
        }
        else if(self.password.text  == self.reenterPassword.text) {
            self.showErrorAlert("Password Input Error", message: "Please make sure you have entered a correct password in both fields.")
        }
        else{
            UserSession.shared.token = "ss"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func showErrorAlert(_ title:String , message:String) {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

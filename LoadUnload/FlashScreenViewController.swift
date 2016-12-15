//
//  FlashScreenViewController.swift
//  LoadUnload
//
//  Created by Admin on 14/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class FlashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpButtonClicked(_ sender: Any) {
        let vc : RegisterViewController = self.storyboard?.instantiateViewController(withIdentifier: "registerViewController") as! RegisterViewController
        present(vc, animated: true, completion: nil)
    }
    @IBAction func loginClicked(_ sender: Any) {
        
        let vc : LogInViewController = self.storyboard?.instantiateViewController(withIdentifier: "logInViewController") as! LogInViewController
        present(vc, animated: true, completion: nil)
    }
}

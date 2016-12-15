//
//  ViewController.swift
//  LoadUnload
//
//  Created by Admin on 13/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController,UITextFieldDelegate {

    var fromTextField: UITextField! = nil
    var toTextField: UITextField! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        let camera = GMSCameraPosition.camera(withLatitude: -33.868,
                                              longitude: 151.2086,
                                              zoom: 14)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let marker = GMSMarker()
//        marker.position = mapView.myLocation
//        marker.icon = UIImage(named: "flag_icon")
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-164)
        
        //
        fromTextField = UITextField(frame: CGRect(x: 40, y: 20, width: view.frame.size.width-80, height: 25.00));
        fromTextField.backgroundColor = UIColor.white
        fromTextField.delegate = self
        self.view.addSubview(fromTextField)
        
        toTextField = UITextField(frame: CGRect(x: 40, y: 47, width: view.frame.size.width-80, height: 25.00));
        toTextField.backgroundColor = UIColor.white
        toTextField.delegate = self
        self.view.addSubview(toTextField)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let vc : FlashScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "flashScreenViewController") as! FlashScreenViewController
//       present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            toTextField.becomeFirstResponder()
        }
        else{
            toTextField.resignFirstResponder()
        }
        return true
    }
}


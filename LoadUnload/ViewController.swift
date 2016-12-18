//
//  ViewController.swift
//  LoadUnload
//
//  Created by Admin on 13/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
class ViewController: UIViewController,UITextFieldDelegate,GMSMapViewDelegate {

    var marker = GMSMarker()
    var fromTextField: UITextField! = nil
    var toTextField: UITextField! = nil
    var fromTFSelected: Bool = false
    var toTFSelected: Bool = false
    
    @IBOutlet var mapView: GMSMapView!
//    var mapView = GMSMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view, typically from a nib.

       
        mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view.addSubview(mapView)
     

        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-179)
        
        //text fields
        fromTextField = UITextField(frame: CGRect(x: 40, y: 20, width: view.frame.size.width-80, height: 25.00));
        fromTextField.backgroundColor = UIColor.white
        fromTextField.delegate = self
        self.view.addSubview(fromTextField)
        
        toTextField = UITextField(frame: CGRect(x: 40, y: 47, width: view.frame.size.width-80, height: 25.00));
        toTextField.backgroundColor = UIColor.white
        toTextField.delegate = self
        self.view.addSubview(toTextField)
        
//        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=Hyderabad&destination=Bengalore&key=AIzaSyBLi8S99bjOzbmlR69DCvGxThJHtXGEeYQ").responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.description)   // result of response serialization
//            
//            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
//            }
//        }
       
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

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == fromTextField {
            fromTFSelected = true
            toTFSelected = false
        }
        else{
            toTFSelected = true
            fromTFSelected = false
        }
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
        return false
    }

    @IBAction func belowOneTonButtonclicked(_ sender: Any) {
        
        
        
    }
    @IBAction func oneTonButtonClicked(_ sender: Any) {
    }
    @IBAction func twoTonButtonClicked(_ sender: Any) {
    }
    @IBAction func aboveOneTonButtonClicked(_ sender: Any) {
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
        
        
        if fromTFSelected {
            marker.position = place.coordinate
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = mapView
            marker.icon = UIImage(named: "source")
            mapView.animate(toLocation: place.coordinate)
            mapView.animate(toZoom: 14)
            fromTextField.text = place.formattedAddress
        }
        else {
            
            let marker1 = GMSMarker()
            marker1.position = place.coordinate
            marker1.appearAnimation = kGMSMarkerAnimationPop
            marker1.map = mapView
            marker1.icon = UIImage(named: "destination")
            mapView.animate(toLocation: place.coordinate)
            mapView.animate(toZoom: 14)
            toTextField.text = place.formattedAddress
            
            // https://maps.googleapis.com/maps/api/directions/json?origin=Chicago,IL&destination=Los+Angeles,CA&waypoints=Joplin,MO|Oklahoma+City,OK&key=YOUR_API_KEY

            
          
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

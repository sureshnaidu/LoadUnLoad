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
    
    //images
    let below_one_ton_Selected = UIImage(named: "open_0_75_ton_selected")
    let below_one_ton = UIImage(named: "open_0_75_ton")
    
    let one_ton_Selected = UIImage(named: "open_selected_1_ton")
    let one_ton = UIImage(named: "open_1_ton")
    
    let below_two_ton_Selected = UIImage(named: "open_selected_1_5_ton")
    let below_two_ton = UIImage(named: "open_1_5_ton")
    
    let two_ton_Selected = UIImage(named: "closed_2_ton_selected")
    let two_ton = UIImage(named: "open_2_ton")
    
    
    @IBOutlet var loadingButton: UIButton!
    @IBOutlet var belowOneTonButton: UIButton!
    @IBOutlet var oneTonButton: UIButton!
    @IBOutlet var aboveOneTonButton: UIButton!
    @IBOutlet var twoTonButton: UIButton!
    
    
    @IBOutlet var mapView: GMSMapView!
    //    var mapView = GMSMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view, typically from a nib.
        
        loadingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        belowOneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        oneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        aboveOneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        twoTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-189)
        
        //text fields
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
        
        if UserSession.shared.token == nil{
            let vc : FlashScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "flashScreenViewController") as! FlashScreenViewController
            present(vc, animated: true, completion: nil)
        }
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
    
    @IBAction func belowOneTonButtonclicked(_ sender: UIButton) {
        buttonsUnSelected()
        if sender.isSelected == false{
            sender.isSelected = true
            sender.setImage(below_one_ton_Selected, for: UIControlState.normal)
        }else{
            sender.isSelected = false
            sender.setImage(below_one_ton, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func oneTonButtonClicked(_ sender: UIButton) {
        buttonsUnSelected()
        if sender.isSelected == false{
            sender.isSelected = true
            sender.setImage(below_one_ton_Selected, for: UIControlState.normal)
        }else{
            sender.isSelected = false
            sender.setImage(below_two_ton, for: UIControlState.normal)
        }
        
        
    }
    func buttonsUnSelected(){
        belowOneTonButton.isSelected = false
        oneTonButton.isSelected = false
        aboveOneTonButton.isSelected = false
        twoTonButton.isSelected = false
        
        twoTonButton.setImage(two_ton, for: UIControlState.normal)
        belowOneTonButton.setImage(below_one_ton, for: UIControlState.normal)
        aboveOneTonButton.setImage(below_two_ton, for: UIControlState.normal)
        oneTonButton.setImage(one_ton, for: UIControlState.normal)
        
    }
    @IBAction func aboveOneTonButtonClicked(_ sender: UIButton) {
        buttonsUnSelected()
        if sender.isSelected == false{
            sender.isSelected = true
            sender.setImage(below_two_ton_Selected, for: UIControlState.normal)
        }else{
            sender.isSelected = false
            sender.setImage(below_two_ton, for: UIControlState.normal)
        }
        
    }
    
    @IBAction func twoTonButtonClicked(_ sender: UIButton) {
        buttonsUnSelected()
        if sender.isSelected == false{
            sender.isSelected = true
            sender.setImage(two_ton_Selected, for: UIControlState.normal)
        }else{
            sender.isSelected = false
            sender.setImage(two_ton, for: UIControlState.normal)
        }
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
            getRoutePoints(from: marker.position, to: marker1.position)
        }
    }
   
    func getRoutePoints(from : CLLocationCoordinate2D , to : CLLocationCoordinate2D) {
     
        Alamofire.request("https://maps.googleapis.com/maps/api/directions/json?origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&key=AIzaSyDxSgGQX6jrn4iq6dyIWAKEOTneZ3Z8PtU").responseJSON { response in
            print(response.description)
            let json = response.result.value as? [String: Any]
            let routes = json?["routes"] as! [[String:Any]]
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"] as? [String:Any]
                let points = routeOverviewPolyline?["points"] as? String
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 5
                polyline.map = self.mapView
            }
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

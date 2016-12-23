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
    
  
    
    @IBOutlet var openButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var openCloseButtonView: UIView!
    @IBOutlet var loadingButton: UIButton!
    @IBOutlet var belowOneTonButton: UIButton!
    @IBOutlet var oneTonButton: UIButton!
    @IBOutlet var aboveOneTonButton: UIButton!
    @IBOutlet var twoTonButton: UIButton!
    @IBOutlet var mapView: GMSMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view, typically from a nib.
        
        loadingButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        belowOneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        oneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        aboveOneTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        twoTonButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        
        openButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0 , 0.0, 0.0)
        openButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 0.0, 0)
       
        closeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0 , 0.0, 0.0)
        closeButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 0.0, 0)
        
        mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-195)
        
        //text fields
        fromTextField = UITextField(frame: CGRect(x: 40, y: 20, width: view.frame.size.width-80, height: 25.00));
        fromTextField.backgroundColor = UIColor.white
        fromTextField.delegate = self
        self.view.addSubview(fromTextField)
        
        toTextField = UITextField(frame: CGRect(x: 40, y: 47, width: view.frame.size.width-80, height: 25.00));
        toTextField.backgroundColor = UIColor.white
        toTextField.delegate = self
        self.view.addSubview(toTextField)
        
        mapView.addSubview(openCloseButtonView)
        openCloseButtonHidden(hidden: true)
        
        prepareToolbar()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserSession.user()?.token == nil{
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
        openCloseButtonHidden(hidden: false)
        openCloseButtonView.frame = CGRect(x: mapView.frame.size.width/3-50, y:mapView.frame.size.height-80 , width: openCloseButtonView.frame.size.width, height: openCloseButtonView.frame.size.height)
        if sender.isSelected == false{
            buttonsUnSelected()
            sender.isSelected = true
            openCloseButtonImages()
        }else{
            sender.isSelected = false
            openCloseButtonHidden(hidden: true)
        }
        
    }
    
    @IBAction func oneTonButtonClicked(_ sender: UIButton) {
        openCloseButtonHidden(hidden: false)
        openCloseButtonView.frame = CGRect(x: mapView.frame.size.width/2-40, y:mapView.frame.size.height-80 , width: openCloseButtonView.frame.size.width, height: openCloseButtonView.frame.size.height)
        if sender.isSelected == false{
            buttonsUnSelected()
            sender.isSelected = true
            openCloseButtonImages()
        }else{
            sender.isSelected = false
            openCloseButtonHidden(hidden: true)
        }
        
    }
    
    @IBAction func aboveOneTonButtonClicked(_ sender: UIButton) {
        openCloseButtonHidden(hidden: false)
        openCloseButtonView.frame = CGRect(x: mapView.frame.size.width/2+30, y:mapView.frame.size.height-80 , width: openCloseButtonView.frame.size.width, height: openCloseButtonView.frame.size.height)
        if sender.isSelected == false{
            buttonsUnSelected()
            sender.isSelected = true
            openCloseButtonImages()
        }else{
            sender.isSelected = false
            openCloseButtonHidden(hidden: true)
        }
        
    }
    
    @IBAction func twoTonButtonClicked(_ sender: UIButton) {
        openCloseButtonHidden(hidden: false)
        openCloseButtonView.frame = CGRect(x: mapView.frame.size.width-90, y:mapView.frame.size.height-80 , width: openCloseButtonView.frame.size.width, height: openCloseButtonView.frame.size.height)
        if sender.isSelected == false{
            buttonsUnSelected()
            sender.isSelected = true
            openCloseButtonImages()
        }else{
            sender.isSelected = false
            openCloseButtonHidden(hidden: true)
        }
        
    }
    
    @IBAction func loadingButtonClicked(_ sender: UIButton) {
       

        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
        
    }
    @IBAction func openButtonClicked(_ sender: UIButton) {
         openCloseButtonHidden(hidden: true)
        if belowOneTonButton.isSelected {
            
        }
        else if oneTonButton.isSelected {
            
        }
        else if aboveOneTonButton.isSelected {
            
        }
        else{
            
        }
        
    }
    @IBAction func closeButtonClicked(_ sender: UIButton) {
         openCloseButtonHidden(hidden: true)
        if belowOneTonButton.isSelected {

        }
        else if oneTonButton.isSelected {

        }
        else if aboveOneTonButton.isSelected {

        }
        else{

        }
    
    }
    
    func openCloseButtonImages(){
        
        if belowOneTonButton.isSelected {
            openButton.setImage(UIImage(named:"open_button"), for: .normal)
            closeButton.setImage(UIImage(named:"close_button"), for: .normal)
        }
       else if oneTonButton.isSelected {
            openButton.setImage(UIImage(named:"open_1_button"), for: .normal)
            closeButton.setImage(UIImage(named:"close_1_button"), for: .normal)
        }
        else if aboveOneTonButton.isSelected {
            openButton.setImage(UIImage(named:"open_1.5_ton_button"), for: .normal)
            closeButton.setImage(UIImage(named:"close_1.5_Ton_button"), for: .normal)
        }
        else{
            openButton.setImage(UIImage(named:"open_2_ton_button"), for: .normal)
            closeButton.setImage(UIImage(named:"close_2_ton_button"), for: .normal)
        }
        
    }
    func openCloseButtonHidden(hidden : Bool) {
        
        if hidden{
              openCloseButtonView.isHidden = true
        
        }
        else{
              openCloseButtonView.isHidden = false
        }
    }
    func buttonsUnSelected(){
        belowOneTonButton.isSelected = false
        oneTonButton.isSelected = false
        aboveOneTonButton.isSelected = false
        twoTonButton.isSelected = false
        
    }
    
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
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

extension ViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        tc.toolbar.title = "Book Your Pick-C Truck"
        tc.toolbar.titleLabel.textColor = UIColorFromRGB(rgbValue: UInt(Constants.YELLOW_THEME_COLOR))
        tc.statusBar.backgroundColor = UIColorFromRGB(rgbValue: UInt(Constants.DARK_THEME_COLOR))
        tc.toolbar.backgroundColor = UIColorFromRGB(rgbValue: UInt(Constants.DARK_THEME_COLOR))
        tc.statusBarStyle = .lightContent
    }
  
}

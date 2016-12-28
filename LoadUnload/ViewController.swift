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
    var locationManager = CLLocationManager()
    var lockButton: UIButton!
    let geocoder = GMSGeocoder()
    var fromLockButton: UIButton?
    var toLockButton: UIButton?
    
    @IBOutlet var openButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var openCloseButtonView: UIView!
    @IBOutlet var loadingButton: UIButton!
    @IBOutlet var belowOneTonButton: UIButton!
    @IBOutlet var oneTonButton: UIButton!
    @IBOutlet var aboveOneTonButton: UIButton!
    @IBOutlet var twoTonButton: UIButton!
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var bookLaterButton: UIButton!
    @IBOutlet var bookNowButton: UIButton!

    @IBOutlet var buttonsView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView?.isMyLocationEnabled = true
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        
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
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-123)
        
        //text fields
        fromTextField = UITextField(frame: CGRect(x: 20, y: 20, width: view.frame.size.width-40, height: 30));
        fromTextField.backgroundColor = UIColor.white
        fromTextField.font = UIFont.systemFont(ofSize: 13)
        fromTextField.delegate = self
        self.view.addSubview(fromTextField)
        
        
        let fromImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        fromImage.image = UIImage(named: "source")
        fromTextField.leftViewMode = UITextFieldViewMode.always
        fromTextField.leftView = fromImage
        
        
        fromLockButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        fromLockButton?.setImage(UIImage(named : "unlock"), for: .normal)
        fromLockButton?.setImage(UIImage(named : "lock"), for: .selected)

        fromLockButton?.addTarget(self, action: #selector(ViewController.fromLockButtonPressed(_:)), for: .touchUpInside)
        fromTextField.rightViewMode = UITextFieldViewMode.always
        fromTextField.rightView = fromLockButton
        
        
        //To TextField
        toTextField = UITextField(frame: CGRect(x: 20, y: fromTextField.frame.size.height+fromTextField.frame.origin.y+4 , width: view.frame.size.width-40, height: 30));
        toTextField.backgroundColor = UIColor.white
        toTextField.delegate = self
        toTextField.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(toTextField)
        
        let toImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        toImage.image = UIImage(named: "destination")
        toTextField.leftViewMode = UITextFieldViewMode.always
        toTextField.leftView = toImage
        
        toLockButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        toLockButton?.setImage(UIImage(named : "unlock"), for: .normal)
        toLockButton?.addTarget(self, action: #selector(ViewController.toLockButtonPressed(_:)), for: .touchUpInside)
        toTextField.rightViewMode = UITextFieldViewMode.always
        toTextField.rightView = toLockButton
        
        
        lockButton = UIButton(frame: CGRect(x: mapView.frame.size.width/2-30, y: mapView.frame.size.height/2-50, width: 60, height: 30))
        lockButton.backgroundColor = UIColorFromRGB(rgbValue: 0x181300)
        lockButton.setTitle("Lock", for: .normal)
        lockButton.addTarget(self, action: #selector(ViewController.lockButtonClicked), for:UIControlEvents.touchUpInside)
        mapView.addSubview(lockButton)
        
        mapView.addSubview(openCloseButtonView)
        openCloseButtonHidden(hidden: true)
        
        prepareToolbar()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserSession.user()?.token == nil{
            let vc : FlashScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "flashScreenViewController") as! FlashScreenViewController
            present(vc, animated: true, completion: nil)
        }else{
            prepareMap()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lockButtonClicked(){
        if PCMapManager.shared.selected == .to {
            if toTextField.text?.characters.count == 0 { return }
            PCMapManager.shared.to.locked = true
            PCMapManager.shared.to.address = toTextField.text
            PCMapManager.shared.to.coordinate = mapCenter()
            if PCMapManager.shared.from.locked == false{
                PCMapManager.shared.selected = .from
            }
        }else{
            if fromTextField.text?.characters.count == 0 { return }
            PCMapManager.shared.from.locked = true
            PCMapManager.shared.from.locked = true
            PCMapManager.shared.from.address = fromTextField.text
            PCMapManager.shared.from.coordinate = mapCenter()
            if PCMapManager.shared.from.locked == false{
                PCMapManager.shared.selected = .to
            }
        }
        if PCMapManager.shared.from.locked == true && PCMapManager.shared.to.locked == true{
            lockButton.isHidden = true
        }else{
            lockButton.isHidden = false
        }
        prepareMap()
    }
    
    func prepareMap(){
        fromLockButton?.setImage(UIImage(named : "unlock"), for: .normal)
        toLockButton?.setImage(UIImage(named : "unlock"), for: .normal)
        // Check locked state
        if PCMapManager.shared.from.locked == true && PCMapManager.shared.to.locked == true {
            // Both are locked
            if let from = PCMapManager.shared.from.coordinate, let to = PCMapManager.shared.to.coordinate {
                getRoutePoints(from: from, to: to)
            }
            fromLockButton?.setImage(UIImage(named : "lock"), for: .normal)
            toLockButton?.setImage(UIImage(named : "lock"), for: .normal)
        }else if PCMapManager.shared.from.locked == true {
            fromLockButton?.setImage(UIImage(named : "lock"), for: .normal)
        }else if PCMapManager.shared.to.locked == true{
            toLockButton?.setImage(UIImage(named : "lock"), for: .normal)
        }else{
            
        }
        
        // Check selected state
        if PCMapManager.shared.from.locked == true && PCMapManager.shared.to.locked == true {
            // No need to select any marker
        }else if PCMapManager.shared.selected == .to {
            // Selected to marker
        }else{
            // Selct from marker
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == fromTextField {
            PCMapManager.shared.selected = .from
        }
        else{
            PCMapManager.shared.selected = .to
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

    func fromLockButtonPressed(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
        
    }
    
    func toLockButtonPressed ( _ sender :UIButton){
        sender.isSelected = !sender.isSelected

    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool){
        self.buttonsViewHide( hidden: true)
        self.openCloseButtonHidden(hidden: true)
    }
    func buttonsViewHide( hidden : Bool ){
        return
        if hidden == true{
            mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
        else{
            mapView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height-123)
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
    
    
    func mapCenter()-> CLLocationCoordinate2D{
        let point:CGPoint = mapView.center;
        let coor:CLLocationCoordinate2D = mapView.projection.coordinate(for: point)
        return coor
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D, completion:@escaping (String?) -> Void)  {
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines
                completion(lines?.joined(separator: "\n"))
            }
        }
    }
    //MARK: Mapview delegate for update address on move
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        self.buttonsViewHide( hidden: false)

        if PCMapManager.shared.from.locked == true && PCMapManager.shared.to.locked == true{
            return
        }
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                var address = ""
                guard let lines = result.lines else {
                    return
                }
                address = lines.joined(separator: ", ")
                
                if PCMapManager.shared.selected == .to {
                    self.toTextField.text = address
                }else{
                    self.fromTextField.text = address
                }
            }
            
        }
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        
        if PCMapManager.shared.selected == .from {
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
//            getRoutePoints(from: marker.position, to: marker1.position)
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

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
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

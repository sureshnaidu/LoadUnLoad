//
//  BookingHostoryViewController.swift
//  LoadUnload
//
//  Created by Admin on 21/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import UIKit

class BookHistory {
    var bookingDate: String?
    var bookingNo: String?
    var cancelRemarks : String?
    var cancelTime: String?
    var cargoDescription : String?
    var cargoType : String?
    var completeTime : String?
    var confirmDate: String?
    var customerID: String?
    var driverID: String?
    var isCancel: Bool?
    var isComplete: Bool?
    var isConfirm: Bool?
    var latitude: Double?
    var loadingUnLoading: Int?
    var loadingUnLoadingDescription: String?
    var locationFrom: String?
    var locationTo:String?
    var longitude: Double?
    var payLoad: String?
    var receiverMobileNo:String?
    var remarks:String?
    var requiredDate:String?
    var toLatitude: Double?
    var toLongitude: Double?
    var vehicleGroup: Int?
    var vehicleNo : String?
    var vehicleType:Int?
    
    init(obj: [String:Any]) {
        bookingDate = obj["BookingDate"] as? String
        bookingNo = obj["BookingNo"] as? String
        cancelRemarks = obj["CancelRemarks"] as? String
        cancelTime = obj["CancelTime"] as? String
        cargoDescription = obj["CargoDescription"] as? String
        cargoType = obj["CargoType"] as? String
        completeTime = obj["CompleteTime"] as? String
        confirmDate = obj["ConfirmDate"] as? String
        customerID = obj["CustomerID"] as? String
        driverID = obj["DriverID"] as? String
        isCancel = obj["IsCancel"] as? Bool
        isComplete = obj["IsComplete"] as? Bool
        isConfirm = obj["IsConfirm"] as? Bool
        latitude = obj["Latitude"] as? Double
        loadingUnLoading = obj["LoadingUnLoading"] as? Int
        loadingUnLoadingDescription = obj["LoadingUnLoadingDescription"] as? String
        locationFrom = obj["LocationFrom"] as? String
        locationTo = obj["LocationTo"] as? String
        longitude = obj["Longitude"] as? Double
        payLoad = obj["PayLoad"] as? String
        receiverMobileNo = obj["ReceiverMobileNo"] as? String
        remarks = obj["Remarks"] as? String
        requiredDate = obj["RequiredDate"] as? String
        toLatitude = obj["ToLatitude"] as? Double
        toLongitude = obj["ToLongitude"] as? Double
        vehicleGroup = obj["VehicleGroup"] as? Int
        vehicleNo = obj["VehicleNo"] as? String
        vehicleType = obj["VehicleType"] as? Int
    }
}



class BookingHostoryViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    var history: [BookHistory] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        
        guard let tc = toolbarController else {
            return
        }
        tc.toolbar.title = "Booking History"
        NetworkInterface.fetchJSON(.bookingList,params: ["mobile":UserSession.user()!.mobileNo!]) { (success, data, response, error) -> (Void) in
            if data != nil && success == true, let array = data?["array"] as? [[String:Any]]{
                for bookObject in array {
                    let obj = BookHistory.init(obj: bookObject)
                    self.history.append(obj)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Instantiate a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryTableViewCell", for: indexPath) as! BookingHistoryTableViewCell

        let obj = history[indexPath.row]
        
        cell.confirmTitleLabel.text = (obj.isConfirm == true) ? "CONFIRMED" : ((obj.isCancel == true) ? "CANCELLED" : "")
        
        if cell.confirmTitleLabel.text == "CONFIRMED" {
            cell.confirmTitleLabel.textColor = UIColorFromRGB(rgbValue: UInt(Constants.YELLOW_THEME_COLOR))
        }
        else{
            cell.confirmTitleLabel.textColor = UIColor.red
        }
        
        cell.dataLabel.text = obj.bookingDate?.ludate ?? ""
        cell.bookingIdLabel.text = obj.bookingNo ?? ""
        cell.fromAdderessLAbel.text = obj.locationFrom ?? ""
        cell.toAddressLabel.text = obj.locationTo ?? ""
        
        // Returning the cell
        return cell
    }
    
    
}

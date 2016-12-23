//
//  UserSession.swift
//  LoadUnload
//
//  Created by Admin on 19/12/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import Foundation
class UserSession: NSObject, NSCoding {
    
    
    static let shared = UserSession()
    var token: String?
    var mobileNo: String?
    var name: String?
    var emailID: String?
    
    // MARK: Coder
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
        aCoder.encode(mobileNo, forKey: "mobileNo")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(emailID, forKey: "emailID")

    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
        token = aDecoder.decodeObject(forKey: "token") as? String
        mobileNo = aDecoder.decodeObject(forKey: "mobileNo") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        emailID = aDecoder.decodeObject(forKey: "emailID") as? String
    }
    

}

extension UserSession{
    static func save() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(UserSession.shared, toFile: path().path)
        if !isSuccessfulSave {
            print("Failed to save user...")
        }
    }
    
    static func logout(){
        NetworkInterface.fetchJSON(.logout) { (success, data, response, error) -> (Void) in
             
        }
        
        UserSession.shared.token = nil
        UserSession.shared.mobileNo = nil
        UserSession.shared.name = nil
        UserSession.shared.emailID = nil
        do {
            try FileManager().removeItem(atPath: path().path)
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        
    }
    
    static func user() -> UserSession? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: path().path) as? UserSession
    }
    
    private static func path() -> URL{
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("usersession")
    }
    
    
    
}

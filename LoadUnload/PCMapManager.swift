//
//  PCMapManager.swift
//  LoadUnload
//
//  Created by Narendra Kumar Rangisetty on 12/27/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PCLocation{
    var coordinate: CLLocationCoordinate2D?
    var address: String?
    var locked: Bool! = false
}
enum PCSelectedLocation{
    case from
    case to
}

class PCMapManager{
    var from = PCLocation()
    var to = PCLocation()
    var selected: PCSelectedLocation = .from
    
    static let shared = PCMapManager()
    private init(){}
    
}

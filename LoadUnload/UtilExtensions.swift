//
//  UtilExtensions.swift
//  LoadUnload
//
//  Created by Narendra Kumar Rangisetty on 12/22/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import Foundation

extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

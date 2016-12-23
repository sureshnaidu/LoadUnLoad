//
//  HUD.swift
//  LoadUnload
//
//  Created by Narendra Kumar Rangisetty on 12/23/16.
//  Copyright © 2016 FreeLancer. All rights reserved.
//

import Foundation
import SVProgressHUD


func showProgress(){
    SVProgressHUD.show()
}

func hideProgress(){
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
}

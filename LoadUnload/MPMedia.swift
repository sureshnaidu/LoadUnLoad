//
//  MPMedia.swift
//  LoanManagementService
//
//  Created by Narendra Kumar Rangisetty on 11/22/16.
//  Copyright © 2016 Ravikumar. All rights reserved.
//

import Foundation
import UIKit
struct MPMedia {
    var fileData : Data!
    var fileName : NSString?
    var mimeType : NSString?
    var fileKey : NSString?
    static func imageMedia(_ image : UIImage, ratio : Float,file: String) -> MPMedia?{
        if let imageData = UIImageJPEGRepresentation(image, 0.3) {
            var media = MPMedia()
            media.fileData = imageData
            media.fileKey = file as NSString?
            media.fileName = "image.png"
            media.mimeType = "image/*"
            return media
        }
        return nil
    }
    
    static func videoMedia(videoData: Data,file: String) -> MPMedia?{
        var media = MPMedia()
        media.fileData = videoData
        media.fileKey = file as NSString?
        media.fileName = "video.mp4"
        media.mimeType = "video/*"
        return media
    }
}

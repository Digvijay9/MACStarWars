//
//  ImageCache.swift
//  MACStarWars
//
//  Created by digvijay mallegowda on 5/12/18.
//  Copyright © 2018 digvijay mallegowda. All rights reserved.
//

import Foundation
import UIKit

class ImageCache{
    static let shared = ImageCache()
    var images : NSCache<NSString, UIImage>
    private init(){
        self.images = NSCache<NSString,UIImage>()
    }
    
}

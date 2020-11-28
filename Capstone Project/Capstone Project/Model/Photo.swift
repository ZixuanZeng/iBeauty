//
//  Photo.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 10/2/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import Foundation
import UIKit

// For sharing objects
class Photo {
    var photo: UIImage!
    
    init(photo: UIImage) {
        self.photo = photo
    }
    
    init() {
    }
}

/* A way of writing singleton:
 
 class Photo {
    static let sharedPhoto = Photo(photo: UIImage!)
    let photo: UIImage!
    private init(_photo: UIImage!){
        self.photo = _photo
    }
 }
 */

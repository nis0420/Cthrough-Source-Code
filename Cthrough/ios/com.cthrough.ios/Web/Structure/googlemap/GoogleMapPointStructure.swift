//
//  GoogleMapPointStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapPointStructure{
    var lat = Double()
    
    var lng = Double()
    
    init(googleMapPointStructure : JSON) {
        self.lat = Double(googleMapPointStructure["lat"].stringValue)!
        self.lng = Double(googleMapPointStructure["lng"].stringValue)!
    }
    
    
}

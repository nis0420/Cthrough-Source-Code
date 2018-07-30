//
//  GoogleMapInfoStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapInfoStructure{
    var zoom = Float()
    
    var center : GoogleMapPointStructure!
    
    init(googleMapInfoStructureJson : JSON) {
        self.zoom = Float(googleMapInfoStructureJson["zoom"].stringValue)!
        self.center = GoogleMapPointStructure(googleMapPointStructure: googleMapInfoStructureJson["center"])
    }
}

//
//  GoogleMapIconStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 4/2/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapIconStructure{

    var url = String()
    
    init(googleMapIconStructure : JSON) {
        self.url = googleMapIconStructure["url"].object as! String
    }
}

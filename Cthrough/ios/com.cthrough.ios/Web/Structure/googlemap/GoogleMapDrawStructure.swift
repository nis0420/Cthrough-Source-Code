//
//  GoogleMapDrawStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapDrawStructure{

    
    var name : String!

    var data : GoogleMapDataStructure!

    var mapInfo : GoogleMapInfoStructure!
    
    init(googleMapDrawStructureJson : JSON) {
        self.name = googleMapDrawStructureJson["name"].stringValue
        self.data = GoogleMapDataStructure(googleMapDataStructure: googleMapDrawStructureJson["data"])
        self.mapInfo = GoogleMapInfoStructure(googleMapInfoStructureJson: googleMapDrawStructureJson["mapInfo"])
    }
}

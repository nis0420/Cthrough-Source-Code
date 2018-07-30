//
//  GoogleMapOverlayStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 4/11/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapOverlayStructure {

    var orginPoint : GoogleMapPointStructure!
    
    var height = Float()
    
    var width = Float()
    
    var ratio = Float()
    
    var url = String()
    
    var name = String()
    
    var type = String()
    
    init(googleMapOverlayStructure : JSON) {
        
        self.orginPoint = GoogleMapPointStructure(googleMapPointStructure: googleMapOverlayStructure["orginPoint"])
        
        self.height = googleMapOverlayStructure["height"].floatValue
        
        self.width = googleMapOverlayStructure["width"].floatValue
        
        self.ratio = googleMapOverlayStructure["ratio"].floatValue
        
        self.url = googleMapOverlayStructure["url"].stringValue
        
        self.name = googleMapOverlayStructure["name"].stringValue
        
        self.type = googleMapOverlayStructure["type"].stringValue
    }
}

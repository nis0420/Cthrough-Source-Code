//
//  GoogleMapImageStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapImageStructure{
    var lat = Double()
    
    var lng = Double()
    
    var url = String()
    
    var originalHeight = Double()
    
    var originalWidth = Double()
    
    var scale = Double()
    
    var zIndex = Double()
    
    var type = String()
    
    var name = String()
    
    var category = String()
    
    
    init(googleMapImageStructure : JSON) {
        self.lat = googleMapImageStructure["position"]["lat"].doubleValue
        
        self.lng = googleMapImageStructure["position"]["lng"].doubleValue
        
        self.url = googleMapImageStructure["icon"]["url"].object as! String
        
        self.originalHeight = Double(googleMapImageStructure["originalHeight"].stringValue)!
        
        self.originalWidth = Double(googleMapImageStructure["originalWidth"].stringValue)!
        
        self.scale = Double(googleMapImageStructure["scale"].stringValue)!
        
        self.zIndex = Double(googleMapImageStructure["zIndex"].stringValue)!
        
        self.type = googleMapImageStructure["type"].stringValue
        
        self.name = googleMapImageStructure["name"].stringValue
        
        self.category = googleMapImageStructure["category"].stringValue
    }
    

}

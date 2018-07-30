//
//  GoogleMapLineStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapLineStructure{

    var paths = [GoogleMapPointStructure]()
    
    var strokeColor = String()
    
    var strokeOpacity = String()
    
    var strokeWeight = String()
    
    var editable = Bool()
    
    var zIndex = Int()
    
    var type = String()
    
    var name = String()
    
    var category = String()
    
    init(googleMapLineStructure : JSON) {
        self.strokeColor = googleMapLineStructure["strokeColor"].stringValue
        
        self.strokeOpacity = googleMapLineStructure["strokeOpacity"].stringValue
        
        self.strokeWeight = googleMapLineStructure["strokeWeight"].stringValue
        
        self.editable = googleMapLineStructure["editable"].boolValue
        
        self.zIndex =  googleMapLineStructure["zIndex"].intValue
        
        self.type = googleMapLineStructure["type"].stringValue
        
        self.name = googleMapLineStructure["name"].stringValue
        
        self.category = googleMapLineStructure["category"].stringValue
        
        for path in googleMapLineStructure["paths"].arrayValue{
            self.paths.append(GoogleMapPointStructure(googleMapPointStructure: path))
        }
    }
    
}

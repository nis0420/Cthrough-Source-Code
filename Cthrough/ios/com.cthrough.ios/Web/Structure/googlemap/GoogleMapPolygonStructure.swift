//
//  GoogleMapPolygonStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapPolygonStructure{
    var paths = [GoogleMapPointStructure]()
    
    var strokeColor = String()
    
    var strokeOpacity = String()
    
    var strokeWeight = String()
    
    var fillColor = String()
    
    var fillOpacity = String()
    
    var editable = Bool()
    
    var zIndex = Int()
    
    var type = String()
    
    var name = String()
    
    var category = String()
    
    init(googleMapPolygonStructure : JSON) {
        self.category = googleMapPolygonStructure["category"].stringValue
        
        self.editable = googleMapPolygonStructure["editable"].boolValue
        
        self.fillColor = googleMapPolygonStructure["fillColor"].stringValue
        
        self.fillOpacity = googleMapPolygonStructure["fillOpacity"].stringValue
        
        self.name = googleMapPolygonStructure["name"].stringValue
        
        self.strokeColor = googleMapPolygonStructure["strokeColor"].stringValue
        
        self.strokeOpacity = googleMapPolygonStructure["strokeOpacity"].stringValue
        
        self.strokeWeight = googleMapPolygonStructure["strokeWeight"].stringValue
        
        self.type = googleMapPolygonStructure["type"].stringValue
        
        self.zIndex = googleMapPolygonStructure["zIndex"].intValue
        
        for path in googleMapPolygonStructure["paths"].arrayValue{
            self.paths.append(GoogleMapPointStructure(googleMapPointStructure: path))
        }
    }
}

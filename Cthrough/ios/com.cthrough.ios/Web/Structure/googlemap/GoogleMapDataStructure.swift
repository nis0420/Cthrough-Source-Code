//
//  GoogleMapDataStructure.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleMapDataStructure{
    var polygons = [GoogleMapPolygonStructure]()
    
    var lines = [GoogleMapLineStructure]()
    
    var images = [GoogleMapImageStructure]()
    
    var overlays = [GoogleMapOverlayStructure]()
    
    
    
    init(googleMapDataStructure : JSON) {
        for poly in googleMapDataStructure["polygons"].arrayValue{
            self.polygons.append(GoogleMapPolygonStructure(googleMapPolygonStructure: poly))
        }
        
        for line in googleMapDataStructure["lines"].arrayValue {
            self.lines.append(GoogleMapLineStructure(googleMapLineStructure: line))
        }
        
        for image in googleMapDataStructure["images"].arrayValue {
            self.images.append(GoogleMapImageStructure(googleMapImageStructure: image))
        }
        
        for overlay in googleMapDataStructure["overlays"].arrayValue {
            self.overlays.append(GoogleMapOverlayStructure(googleMapOverlayStructure: overlay))
        }
    }
}

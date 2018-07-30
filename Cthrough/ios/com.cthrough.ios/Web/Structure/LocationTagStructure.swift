//
//  LocationTagStructure.swift
//  WebApiSample
//
//  Created by Nischal Panwala on 2/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

struct LocationTagStructure : Codable {
    var id : Int
    
    var latitude : Double
    
    var longitude : Double
    
    var altitude : Int
    
    var name : String
    
    var fullname : String
    
    var description : String
    
    var buildingType : String
}

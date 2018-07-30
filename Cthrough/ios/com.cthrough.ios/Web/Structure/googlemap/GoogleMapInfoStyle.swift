//
//  GoogleMapInfoStyle.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

struct GoogleMapInfoStyle: Codable {

    var featureType : String
    var stylers : [Styler]
    
    struct Styler : Codable{
        var visibility : String
    }
}

//
//  GoogleCustomMapService.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoogleCustomMapService: NSObject {
    private static var googleMapDrawStructure : GoogleMapDrawStructure?
    
    public static func getGoogleCustomMap() -> GoogleMapDrawStructure {
        let queryParameter = QueryParameter()
        
        let url = "https://s3.amazonaws.com/cthrough-map-data/venues/State+Fair+of+Texas/zoo%2Bstatefair.json"
        //https://s3.us-east-2.amazonaws.com/cthrough/GoogleMappingSoftware/ShapeData/DZ_3%3A18.json
        
        
        let data = WebApiCalls.sendGet(url: url, queryParameters: queryParameter)
        let json = JSON(data.0!)
        googleMapDrawStructure = GoogleMapDrawStructure(googleMapDrawStructureJson: json)
        return googleMapDrawStructure!
    }
}


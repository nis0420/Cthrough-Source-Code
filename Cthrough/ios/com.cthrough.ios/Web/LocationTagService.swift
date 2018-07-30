//
//  LocationTagService.swift
//  WebApiSample
//
//  Created by Nischal Panwala on 2/20/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

class LocationTagService {
    private static var _minDistance = 90
    private static var _maxDistance = 170
    private static var _limit = 10
    private static var locationTagStructure : [LocationTagStructure]?
    
    public static func getNearbyLocations(latitude : Double, longitude : Double) -> [LocationTagStructure]{
        let queryParameter = QueryParameter()

        queryParameter.addParameter(key: "latitude", val: String(latitude))
        queryParameter.addParameter(key: "longitude", val: String(longitude))
        queryParameter.addParameter(key: "distanceMin", val: String(_minDistance))
        queryParameter.addParameter(key: "distanceMax", val: String(_maxDistance))
        queryParameter.addParameter(key: "limit", val: String(_limit))

        let url = "http://server.cthroughmap.com:8080/Cthrough/outdoor/getNearbyLocation?"
        let data = WebApiCalls.sendGet(url: url, queryParameters: queryParameter)
        do {
            let decoder = JSONDecoder()
            locationTagStructure = try decoder.decode(FailableCodableArray<LocationTagStructure>.self, from: data.0!)
                .elements
        } catch let error {
            print(error.localizedDescription)
            
        }

        return locationTagStructure!
        
    }
    
    public static func postNearbyLocations(latitude : Double, longitude : Double) -> String{
        let queryParameter = QueryParameter()
        
        queryParameter.addParameter(key: "latitude", val: String(latitude))
        queryParameter.addParameter(key: "longitude", val: String(longitude))
        queryParameter.addParameter(key: "distanceMin", val: String(_minDistance))
        queryParameter.addParameter(key: "distanceMax", val: String(_maxDistance))
        queryParameter.addParameter(key: "limit", val: String(_limit))
        
        let url = "https://jsonplaceholder.typicode.com/todos"
        
        let data = WebApiCalls.sendPost(url: url, queryParameters: queryParameter)
        return data
        
    }
    
    
    struct FailableDecodable<Base : Decodable> : Decodable {
        
        let base: Base?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            self.base = try? container.decode(Base.self)
        }
    }
    
    struct FailableCodableArray<Element : Codable> : Codable {
        
        var elements: [Element]
        
        init(from decoder: Decoder) throws {
            
            var container = try decoder.unkeyedContainer()
            
            var elements = [Element]()
            if let count = container.count {
                elements.reserveCapacity(count)
            }
            
            while !container.isAtEnd {
                if let element = try container
                    .decode(FailableDecodable<Element>.self).base {
                    
                    elements.append(element)
                }
            }
            
            self.elements = elements
            
        }
    }
}



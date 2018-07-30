//
//  ARLocation.swift
//  Cthrough
//
//  Created by Nischal Panwala on 1/5/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import GoogleMaps

class ARLocation : CustomStringConvertible {
    private var _currentLocation : CLLocation = CLLocation()
    
    private var _timestamp : Double = Double()
    
    /**
     Constructor
     
     - parameters:
        - CurrentLocation : Users Current Location
        - Timestamp : Current Date and Time
     */
    init(CurrentLocation : CLLocation, Timestamp : Double) {
        self._currentLocation = CurrentLocation
        self._timestamp = Timestamp
    }
    
    /**
     Location object for the ARLocation
     */
    public var currentLocation : CLLocation {
        get{return _currentLocation}
    }
    
    /**
     Timestamp for the latest location
     */
    public var timestamp : Double {
        get{return _timestamp}
    }
    
    public static func convertToCllocation(latitude : Double, longitude : Double) -> CLLocation{
        let convertedToClLocation: CLLocation =  CLLocation(latitude: latitude, longitude: longitude)
        
        return convertedToClLocation
    }
    
    public static func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    public static func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    public static func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
    
    /**
     This function is used to retrieve toString.
     */
    var description : String{
        return "[Location = \(_currentLocation)] [Timestamp = \(_timestamp)]"
    }
}

extension Date{
    /**
     extention to convert date to millisecond.
     
     - returns:
     Millisecond in int
     */
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

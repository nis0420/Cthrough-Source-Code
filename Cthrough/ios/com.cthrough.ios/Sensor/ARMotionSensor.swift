//
//  ARMotionSensor.swift
//  Cthrough
//
//  Created by Nischal Panwala on 1/7/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

/**
 This class is a swift object class for motion sensor detection.
 */
class ARMotionSensor : CustomStringConvertible {
    private var _tiltAngle : Double = Double()
    
    private var _timestamp : Double = Double()
    
    private var _compass : Double = Double()
    
    init(tiltAngle : Double, timestamp : Double, compass : Double) {
        self._tiltAngle = tiltAngle
        self._timestamp = timestamp
        self._compass = compass
    }
    
    /**
     Accuracy of digital compass.
     */
    public var compass : Double {
        get{return _compass}
    }
    
    /**
     Tilt angle in vertical direction.
     */
    public var tiltAngle : Double {
        get{return _tiltAngle}
    }
    
    /**
     Timestamp of current reading.
     */
    public var timestamp : Double {
        get{return _timestamp}
    }
    
    /**
     ToString for debug purposes.
     */
    var description : String{
        return "headingAccuracy = tiltAngle = \(_tiltAngle) timestamp = \(_timestamp)"
    }
}

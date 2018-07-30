//
//  MotionSensors.swift
//  Cthrough
//
//  Created by Nischal Panwala on 1/8/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import CoreMotion

class MotionSensors {
    private var _arMotionSensor : ARMotionSensor?
    private weak var _motionSensorDelegate : MotionSensorListenerDelegate!
    var motionManager = CMMotionManager()
    private static var TILT_ALPHA : Double = 0.15
    private static var TILT_NOISE_THRESHOLD : Double = 3
    
    
    public func setMotionSensorListenerDelegate(motionSensorListenerDelegate : MotionSensorListenerDelegate){
        self._motionSensorDelegate = motionSensorListenerDelegate
    }
    
    public func removeMotionSensorListenerDelegate(){
        self._motionSensorDelegate = nil
    }
    
    public func start() throws{
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
        
         motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.main) {
            
            (motion : CMDeviceMotion!, error : Error!) in
            self.outputMotionData(motion : motion)

            if error != nil{
                print("Error : \(error)")
            }
        }
        
    }
    
    public func stop(){
        motionManager.stopDeviceMotionUpdates()
    }
    
    private func outputMotionData(motion : CMDeviceMotion){
        
        var pitch = motion.attitude.pitch
        
        if(motion.attitude.roll > -.pi/2 && motion.attitude.roll < .pi/2){
            pitch = .pi - pitch
        }
        
        _arMotionSensor = ARMotionSensor(tiltAngle: pitch, timestamp: Double(Date().ticks), compass: motion.heading.degreesToRadians)
        
        if self._motionSensorDelegate != nil{
            _motionSensorDelegate.motionSensorAvailable(motionSensor: _arMotionSensor!)
        }
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

//
//  MotionSensorListener.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/21/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

protocol MotionSensorListenerDelegate : class {
    func motionSensorAvailable(motionSensor : ARMotionSensor)
}

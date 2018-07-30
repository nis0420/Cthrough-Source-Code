//
//  MotionError.swift
//  Cthrough
//
//  Created by Nischal Panwala on 1/9/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

enum MotionError : Error {
    case MotionSensorNotAvailableException(String)
    case MotionSensorValueNotAvailableException(String)

}

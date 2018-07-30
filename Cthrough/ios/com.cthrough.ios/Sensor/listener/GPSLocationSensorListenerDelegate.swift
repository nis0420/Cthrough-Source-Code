//
//  GPSLocationSensorListenerDelegate.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/22/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit


protocol GPSLocationSensorListenerDelegate : class {
    func GPSLocationAvailable(location : ARLocation)
}

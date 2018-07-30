//
//  LocationNotAvailableException.swift
//  Cthrough
//
//  Created by Nischal Panwala on 1/4/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

enum LocationError: Error {
    case LocationNotAvailableException(String)
    case LocationServiceNotAvailableException(String)
    case LocationPermissionNotAvailableException(String)
}

//
//  OnClickListenerDelegate.swift
//  Cthrough
//
//  Created by Nischal Panwala on 3/28/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit
import SceneKit


protocol OnClickListenerDelegate : class {
    func OnClick(view : UIView!, text : String, sceneVec : SCNVector3)
}

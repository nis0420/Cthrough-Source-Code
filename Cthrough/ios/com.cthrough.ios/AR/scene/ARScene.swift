//
//  ARScene.swift
//  Cthrough
//
//  Created by Nischal Panwala on 2/28/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//
import UIKit

//Do Not Delete
class ARScene {
    
    private var _name : String = String()
    
    init(name : String) {
        self._name = name
    }
    
    public var name : String {
        get{return _name}
        set{self._name = newValue}
    }
    
    //Do not delete this method
    public func create() -> Void{
        
    }
    
    //Do not delete this method
    public func start() -> Void{
        
    }
    
    //Do not delete this method
    public func stop() -> Void{
        
    }
}

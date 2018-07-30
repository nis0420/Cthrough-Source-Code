//
//  ARProperties.swift
//  Cthrough
//
//  Created by Nischal Panwala on 12/23/17.
//  Copyright © 2017 Cthrough. All rights reserved.
//

import UIKit

class ARProperties {
    
    /**
     Defaul Constructor.
     */
    init() {
        _properties = [String : String]()
    }
    
    private var _properties = [String : String]()
    
   
    /**
     Adds property to the properties.
     
     - parameters:
        - key: Key for the property
        - value: The value of that property, if key is not found returns null
     */
    func addProperty(key : String, value : String){
        _properties[key] = value
    }
    
    /**
     get property
     
     - parameters:
         - key: Key for the property
     */
    func getProperty(key : String) -> String?{
        if hasProperty(key : key) {
            return _properties[key]!
        }
        
        return nil
    }
    
    /**
     edit the property.
     
     - parameters:
        - key: key of the property
        - value: value of the property
     */
    func editPropery(key : String, value : String) -> Bool{
        if hasProperty(key : key) {
            _properties[key] = value
            return true
        }
        
        return false
    }
    
    func getKeySet() -> Dictionary<String, String>.Keys{
        return _properties.keys
    }
    
    /**
     Checks whether the property is contained by properties or not.
     
     - parameters:
         - key: key of the property
         - value: value of the property
     */
    func hasProperty(key : String) -> Bool{
        return _properties[key] != nil
    }
}

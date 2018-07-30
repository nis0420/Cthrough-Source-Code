//
//  QueryParameter.swift
//  WebApiSample
//
//  Created by Nischal Panwala on 2/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

class QueryParameter :  CustomStringConvertible {
    
    private var _queryParameters = [String : String]()
    
    private var _serializeParameter : String = String()
    
    init() {
        self._queryParameters = [String : String]()
        self._serializeParameter = String()
    }
    
    public func addParameter(key : String, val : String) -> Void{
        _queryParameters[key] = val
        
        
        if !_serializeParameter.trimmingCharacters(in: .whitespaces).isEmpty {
            _serializeParameter += "&"
        }
        
        _serializeParameter += "\(key.encodeUrl())=\(val.encodeUrl())"
    }
    
    var description: String{
        return _serializeParameter
    }
}

extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
}


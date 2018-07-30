//
//  WebApiCalls.swift
//  WebApiSample
//
//  Created by Nischal Panwala on 2/19/18.
//  Copyright © 2018 Cthrough. All rights reserved.
//

import UIKit

class WebApiCalls{
    
    public static func sendGet(url : String, queryParameters : QueryParameter) -> (Data?, URLResponse?, Error?){
        let endpoint: String = "\(url)\(queryParameters.description)"
        guard let url = URL(string: endpoint) else {
            print("Error : cannot create URL")
            return (nil, nil, nil)
        }
        
        let data =  URLSession(configuration: .default).synchronousDataTask(with: url)
        
        return data
    }
    
    public static func sendPost(url : String, queryParameters : QueryParameter) -> String{
        let endpoint: String = url
        guard let url = URL(string: endpoint) else {
            print("Error : cannot create URL")
            return "Error : cannot create URL"
        }
        let data = URLSession(configuration: .default).synchronousPostDataTask(with: url, queryParameters: queryParameters.description)
        
        return data
    }
}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
    
    func synchronousPostDataTask(with url: URL, queryParameters : String) -> String {
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = queryParameters
        request.httpBody = postString.data(using: .utf8)
        var responseString : String?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            responseString = String(data: data, encoding: .utf8)
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return responseString!
    }
}



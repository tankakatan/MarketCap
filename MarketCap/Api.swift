//
//  Api.swift
//  MarketCap
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum FetchError: Error {
    case invalidUrl
}

public struct Api {
    
    static func fetch (url urlString: String,
                       then: @escaping (Data?, URLResponse?, Error?) -> Void,
                       method: RequestMethod = RequestMethod.get,
                       headers: [String: String] = [:],
                       body: Data? = nil) {
        
        guard let urlComponents = URLComponents (string: urlString),
            let url = urlComponents.url else {
                
                return then (nil, nil, FetchError.invalidUrl)
        }
        
        var request = URLRequest (url: url)
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue (header.value, forHTTPHeaderField: header.key)
        }
        
        if body != nil { request.httpBody = body }
        
        let session = URLSession (configuration: .default)
        let task = session.dataTask (with: request, completionHandler: then)
        
        task.resume ()
    }
}

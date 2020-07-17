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

public struct Network {
    
    static func fetch (
        url urlString: String,
        method: RequestMethod = RequestMethod.get,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        
        guard let urlComponents = URLComponents (string: urlString),
            let url = urlComponents.url else {
                return then (nil, nil, FetchError.invalidUrl)
        }
        
        var request = URLRequest (url: url)
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue (header.value, forHTTPHeaderField: header.key)
        }

        if body != nil {

            request.httpBody = body
//            do {
//                request.httpBody = try JSONEncoder ().encode (body)
//            } catch {
//                return then (nil, nil, error)
//            }
        }
        
        let session = URLSession (configuration: .default)
        let task = session.dataTask (with: request, completionHandler: then)
        
        task.resume ()
    }
    
    static func fetchJson<Response: Decodable> (
        url: String,
        method: RequestMethod = RequestMethod.get,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {

        return fetch (
            url: url,
            method: method,
            headers: headers,
            body: body,
            then: { (data: Data?, resp: URLResponse?, err: Error?) -> Void in
            
                if data == nil {
                    return then (nil, resp, err)
                }
                
                do {
                    then (
                        try JSONDecoder ().decode (Response.self, from: data!),
                        resp,
                        err
                    )
                } catch {
                    then (nil, resp, error)
                }
            }
        )
    }
    
    static func get (
        url: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        return fetch (
            url: url,
            method: RequestMethod.get,
            headers: headers,
            body: body,
            then: then
        )
    }
    
    static func post (
        url: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        return fetch (
            url: url,
            method: RequestMethod.post,
            headers: headers,
            body: body,
            then: then
        )
    }
    
    static func getJson<Response: Decodable> (
        url: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {
        return fetchJson (
            url: url,
            method: RequestMethod.get,
            headers: headers,
            body: body,
            then: then
        )
    }
    
    static func postJson<Response: Decodable> (
        url: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {
        return fetchJson (
            url: url,
            method: RequestMethod.post,
            headers: headers,
            body: body,
            then: then
        )
    }
}

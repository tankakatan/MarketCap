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

enum DateError: String, Error {
    case invalidDate
}

public struct Network {
    
    public static func fetch (
        _ urlString: String,
        method: RequestMethod = RequestMethod.get,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        
        guard var urlComponents = URLComponents (string: urlString) else {
                return then (nil, nil, FetchError.invalidUrl)
        }
        
        if query != nil {
            urlComponents.queryItems = []
            for (k, v) in query! {
                urlComponents.queryItems?.append (URLQueryItem (name: k, value: v))
            }
        }
        
        var request = URLRequest (url: urlComponents.url!.absoluteURL)
        request.httpMethod = method.rawValue
        
        for (k, v) in headers {
            request.setValue (v, forHTTPHeaderField: k)
        }
        
//        print ("Request: \(String (describing: request.allHTTPHeaderFields))")

        if body != nil {

            request.httpBody = body
//            do {
//                request.httpBody = try JSONEncoder ().encode (body)
//            } catch {
//                return then (nil, nil, error)
//            }
        }
        
        URLSession.shared.dataTask (with: request, completionHandler: then).resume ()
    }
    
    public static func fetchJson<Response: Decodable> (
        _ url: String,
        method: RequestMethod = RequestMethod.get,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {

        let defaultHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

        return fetch (
            url,
            method: method,
            headers: defaultHeaders.merging (headers) { (_, new) in new },
            query: query,
            body: body
        
        ) { (data: Data?, resp: URLResponse?, err: Error?) -> Void in
                        
            if data == nil {
                return then (nil, resp, err)
            }

//            print ("Data: \(String (decoding: data!, as: UTF8.self))")

            do {
                
                let decoder = JSONDecoder ()

                let dateFormatter = DateFormatter ()
                dateFormatter.calendar = Calendar (identifier: .iso8601)
                dateFormatter.locale = Locale (identifier: "en_US_POSIX")
                dateFormatter.timeZone = TimeZone (secondsFromGMT: 0)
                
                decoder.dateDecodingStrategy = .custom ({ (decoder) -> Date in

                    let container = try decoder.singleValueContainer ()
                    let dateStr = try container.decode (String.self)

                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                    if let date = dateFormatter.date (from: dateStr) {
                        return date
                    }

                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                    if let date = dateFormatter.date (from: dateStr) {
                        return date
                    }
                    
                    throw DateError.invalidDate
                })

                then (try decoder.decode (Response.self, from: data!), resp, err)

            } catch {
                
//                print ("\nDecoder error: \(String (describing: error))\n")

                then (nil, resp, error)
            }
        }
    }
    
    public static func get (
        _ url: String,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        return fetch (
            url,
            method: RequestMethod.get,
            headers: headers,
            query: query,
            body: body,
            then
        )
    }
    
    public static func post (
        _ url: String,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        return fetch (
            url,
            method: RequestMethod.post,
            headers: headers,
            query: query,
            body: body,
            then
        )
    }
    
    public static func getJson<Response: Decodable> (
        _ url: String,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {
        return fetchJson (
            url,
            method: RequestMethod.get,
            headers: headers,
            query: query,
            body: body,
            then
        )
    }
    
    public static func postJson<Response: Decodable> (
        _ url: String,
        headers: [String: String] = [:],
        query: [String: String]? = nil,
        body: Data? = nil,
        _ then: @escaping (Response?, URLResponse?, Error?) -> Void
    ) {
        return fetchJson (
            url,
            method: RequestMethod.post,
            headers: headers,
            query: query,
            body: body,
            then
        )
    }
}

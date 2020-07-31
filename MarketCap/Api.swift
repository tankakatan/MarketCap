//
//  Api.swift
//  MarketCap
//
//  Created by Denis on 19.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import AppKit

fileprivate struct Settings {

    static var apiUrl: String? {
        get {
            return (Bundle.main.object (forInfoDictionaryKey: "ApiUrl") as? String)!
        }
    }
    
    static var iconUrl: String? {
        get {
            return (Bundle.main.object (forInfoDictionaryKey: "IconUrl") as? String)!
        }
    }
}

public struct Api {
    
    private static func endpoint (_ path: String) -> String {
        return Settings.apiUrl! + path
    }

    public static func currencies (_ then: @escaping ([Currency]?, Error?) -> Void) {
        
        let query = [
            "vs_currency": "usd",
            "order": "market_cap_desc",
            "per_page": "250",
            "page": "1",
            "sparkline": "false",
        ]

        Network.getJson (endpoint ("/coins/markets"), query: query) {
            (response: [Currency]?, _: URLResponse?, error: Error?) in
            
            if response != nil {
                then (response, error)
            } else  {
                then (nil, error)
            }
        }
    }
}

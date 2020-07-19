//
//  Api.swift
//  MarketCap
//
//  Created by Denis on 19.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation
import Network

fileprivate struct Settings {
    static var apiUrl: String? {
        get {
            return (Bundle.main.object (forInfoDictionaryKey: "ApiUrl") as? String)!
        }
    }
}

public struct Currency: Decodable {
    var id: String
    var name: String
    var symbol: String
}

public struct Api {
    
    private static func endpoint (_ path: String) -> String {
        return Settings.apiUrl! + "/" + path
    }

    public static func list (_ then: @escaping ([Currency]?, URLResponse?, Error?) -> Void) {
        Network.getJson (endpoint ("coins/list"), then)
    }
}

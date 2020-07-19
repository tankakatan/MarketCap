//
//  Api.swift
//  MarketCap
//
//  Created by Denis on 19.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation
import Network
import Keys

struct Settings {
    static var apiUrl: String? {
        get {
            return (
                ((Bundle.main.object (forInfoDictionaryKey: "ApiDomain") as? String)!) + "/" +
                ((Bundle.main.object (forInfoDictionaryKey: "ApiVersion") as? String)!)
            )
        }
    }
}

public struct Currency: Decodable {
    var id: Int
    var name: String
    var symbol: String
}

public struct ResponseStatus: Decodable {
    var timestamp: String
    var errorCode: Int
    var errorMessage: String?
    var elapsed: Int
    var cost: Int
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case cost = "credit_count"
        case elapsed = "elapsed"
    }
}

public struct CurrencyList: Decodable {
    var data: [Currency]
    var status: ResponseStatus
}

public struct Api {
    
    public static func list (_ then: @escaping (CurrencyList?, URLResponse?, Error?) -> Void) {
        Network.getJson (
            Settings.apiUrl! + "/cryptocurrency/listings/latest",
            headers: ["X-CMC_PRO_API_KEY": MarketCapKeys ().cmcApiKey],
            then
        )
    }
}

//
//  Api.swift
//  MarketCap
//
//  Created by Denis on 19.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation
import Network
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

public struct Currency: Decodable, Identifiable {
    public var id: String
    public var name: String
    public var symbol: String
    public var rank: Int?
    public var icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case rank = "market_cap_rank"
        case icon = "thumb"
    }
}

public struct CurrencyResponse: Decodable {
    public var coins: [Currency]
}

public struct Api {
    
    private static func endpoint (_ path: String) -> String {
        return Settings.apiUrl! + "/" + path
    }
    
    public static func asset (_ icon: String) -> URL? {
        return URLComponents (string: Settings.iconUrl! + "/" + icon)?.url
    }

    public static func currencies (_ then: @escaping ([Currency]?, Error?) -> Void) {
        Network.getJson (endpoint ("search?locale=en&img_path_only=1")) {
            (response: CurrencyResponse?, _: URLResponse?, error: Error?) in
            
            if response != nil {
                then (response!.coins, error)
            } else  {
                then (nil, error)
            }
        }
    }
}

public class CurrencyLoader: ObservableObject {

    @Published var currencies = [] as [Currency]
    
    init () {
        Api.currencies () { (currencies: [Currency]?, error: Error?) in

            guard let currencies = currencies else {
                print ("No currencies fetched, error \(String (describing: error))")
                return
            }

            DispatchQueue.main.async {
                self.currencies = currencies
            }
        }
    }
}

enum IconLoaderError: Error {
    case invalidUrl (_ url: String)
}

public class IconLoader: ObservableObject {
    
    @Published var icon: Image?
    private var loading: AnyCancellable?
    private let source: URL
    
    init (icon: String) throws {
        guard let source = Api.asset (icon) else {
            throw IconLoaderError.invalidUrl (icon)
        }

        self.source = source
    }
    
    deinit {
        cancel ()
    }
    
    public func load () {
        loading = URLSession.shared.dataTaskPublisher (for: source)
            .map { Image (nsImage: NSImage (data: $0.data) ?? NSImage ()) }
            .replaceError (with: nil)
            .receive (on: DispatchQueue.main)
            .assign (to: \.icon, on: self)
    }
    
    public func cancel () {
        loading?.cancel ()
    }
}

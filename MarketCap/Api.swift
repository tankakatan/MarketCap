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

fileprivate struct Settings {
    static var apiUrl: String? {
        get {
            return (Bundle.main.object (forInfoDictionaryKey: "ApiUrl") as? String)!
        }
    }
}

public struct Currency: Decodable, Identifiable {
    public var id: String
    public var name: String
    public var symbol: String
}

public struct Api {
    
    private static func endpoint (_ path: String) -> String {
        return Settings.apiUrl! + "/" + path
    }

    public static func currencies (_ then: @escaping ([Currency]?, URLResponse?, Error?) -> Void) {
        Network.getJson (endpoint ("coins/list"), then)
    }
}

public class CurrencyLoader: ObservableObject {
    
//    var didChange = PassthroughSubject<Currencies, Never> ()

    @Published var currencies = [] as [Currency]
//        {
//        didSet {
//            didChange.send (self)
//        }
//    }
    
    init () {
        Api.currencies () { (currencies: [Currency]?, _, error: Error?) in

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
    
    @Published var image: Image?
    
    private let source: URL
    
    init (_ urlString: String) throws {
        guard let urlComponents = URLComponents (string: urlString),
            let source = urlComponents.url else {
                throw IconLoaderError.invalidUrl (urlString)
        }
        
        self.source = source
    }
    
    public func load () {
    }
    
    public func cancel () {
    }
}

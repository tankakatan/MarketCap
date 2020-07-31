//
//  CurrencyListLoader.swift
//  MarketCap
//
//  Created by Denis on 01.08.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Foundation

public class CurrencyListLoader: ObservableObject {

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

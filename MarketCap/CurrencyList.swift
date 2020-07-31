//
//  ContentView.swift
//  MarketCap
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyList: View {
    
    var currencies: [Currency]

    var body: some View {
        List {
            ForEach (currencies) {
                CurrencyRow (currency: $0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        CurrencyList (currencies: [Currency (
            id: "test_id",
            name: "Test",
            symbol: "TST",
            rank: 1,
            image: "coins/images/1/thumb/bitcoin.png"
        )])
    }
}

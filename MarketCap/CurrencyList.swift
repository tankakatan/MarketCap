//
//  ContentView.swift
//  MarketCap
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyList: View {
    
    @ObservedObject var loader = CurrencyListLoader ()

    var body: some View {
        Group {
            if loader.currencies.count == 0 {
                Loading ().frame (maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach (loader.currencies) {
                        CurrencyRow (currency: $0)
                    }
                }
            }
        }.frame (width: 400, height: 640)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @State static var currency = Currency (
        id: "test_id",
        name: "Test",
        symbol: "TST",
        rank: 1,
        icon: "coins/images/1/thumb/bitcoin.png"
    )

    static var previews: some View {
        CurrencyList ()
    }
}

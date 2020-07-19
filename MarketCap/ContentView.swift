//
//  ContentView.swift
//  MarketCap
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loader = CurrencyLoader ()

    var body: some View {
        CurrenciesView (currencies: loader.currencies)
    }
}

struct CurrenciesView: View {
    
    var currencies: [Currency]

    var body: some View {
        ScrollView {
            VStack {
                ForEach (currencies) { currency in
                    CurrencyView (currency: currency)
                }
            }
        }.frame (width: 500, height: 500, alignment: .center)
    }
}

struct CurrencyView: View {

    var currency: Currency

    var body: some View {
        Text (currency.name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView ()
    }
}

//
//  App.swift
//  MarketCap
//
//  Created by Denis on 01.08.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct App: View {
    @ObservedObject var loader = CurrencyListLoader ()

    var body: some View {
        Group {
            if loader.currencies.count == 0 {
                Loading ().frame (maxWidth: .infinity, maxHeight: .infinity)
            } else {
                CurrencyList (currencies: loader.currencies)
            }
        }.frame (width: 400, height: 640)
    }
}

struct App_Previews: PreviewProvider {
    static var previews: some View {
        App ()
    }
}

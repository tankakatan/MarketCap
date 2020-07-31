//
//  CurrencyView.swift
//  MarketCap
//
//  Created by Denis on 25.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyView: View {

    var currency: Currency

    var body: some View {
        VStack {
            CurrencyIcon (icon: currency.image)
            Text (currency.name)
        }.frame (maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView (currency: Currency (
            id: "test_id",
            name: "Test",
            symbol: "TST",
            rank: 1,
            image: "coins/images/1/thumb/bitcoin.png"
        ))
    }
}

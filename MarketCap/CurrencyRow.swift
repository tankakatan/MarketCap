//
//  SwiftUIView.swift
//  MarketCap
//
//  Created by Denis on 24.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyRow: View {

    var currency: Currency

    var body: some View {

        HStack {

            CurrencyIcon (icon: currency.icon)
                .aspectRatio (1.0, contentMode: .fit)
                .frame (width: 32, height: 32)
                .fixedSize (horizontal: true, vertical: false)
                .cornerRadius (4.0)

            Text (currency.symbol)
            Text (currency.name)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRow (currency: Currency (
            id: "test_id",
            name: "Test",
            symbol: "TST",
            rank: 1,
            icon: "coins/images/1/thumb/bitcoin.png"
        ))
    }
}

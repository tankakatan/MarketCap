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

            CurrencyLogo (icon: currency.image)
                .aspectRatio (1.0, contentMode: .fit)
                .frame (width: 32, height: 32)
                .fixedSize (horizontal: true, vertical: false)

            VStack (alignment: .leading) {
                Text (currency.symbol)
                    .fontWeight (.bold)
                    .truncationMode (.tail)
                    .frame (minWidth: 20)

                Text (currency.name)
                    .font (.caption)
                    .opacity (0.625)
                    .truncationMode (.middle)
            }
            
            Spacer()

            if currency.rank != nil {
                Text ("$\(String (currency.price!))")
                    .font (.caption)
                    .foregroundColor (.yellow)
                    .padding (.trailing, 8)
            }
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
            image: "coins/images/1/thumb/bitcoin.png"
        ))
    }
}

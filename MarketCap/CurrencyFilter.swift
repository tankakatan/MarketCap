//
//  CurrencyFilter.swift
//  MarketCap
//
//  Created by Denis on 31.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyFilter: View {
    
    @Binding fileprivate var currency: String

    var body: some View {
        TextField (/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/, text: $currency)
    }
}

struct CurrencyFilter_Previews: PreviewProvider {

    @State static var currency: String = "Test"

    static var previews: some View {
        CurrencyFilter (currency: $currency)
    }
}

//
//  CurrencyIcon.swift
//  MarketCap
//
//  Created by Denis on 24.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyLogo: View {

    @ObservedObject private var loader: CurrencyLogoLoader

    private let placeholder: Image

    init (icon: String?, placeholder: String = "icon-placeholder") {
        loader = CurrencyLogoLoader (icon)
        self.placeholder = Image (placeholder) as Image
    }
    
    var body: some View {
        image
            .onAppear (perform: loader.load)
            .onDisappear (perform: loader.cancel)
    }

    private var image: some View {
        Group {
            if loader.logo != nil {
                loader.logo!.resizable ()
            } else {
                placeholder.resizable ()
            }
        }
    }
}

struct CurrencyIcon_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyLogo (icon: "coins/images/1/thumb/bitcoin.png")
    }
}

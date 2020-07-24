//
//  CurrencyIcon.swift
//  MarketCap
//
//  Created by Denis on 24.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyIcon: View {

    @ObservedObject private var loader: IconLoader

    private let placeholder: Image

    init (icon: String?, placeholder: String = "icon-placeholder") {
        loader = IconLoader (icon)
        self.placeholder = Image (placeholder) as Image
    }
    
    var body: some View {
        image
            .onAppear (perform: loader.load)
            .onDisappear (perform: loader.cancel)
    }

    private var image: some View {
        Group {
            if loader.icon != nil {
                loader.icon!.resizable ()
            } else {
                placeholder.resizable ()
            }
        }
    }
}

struct CurrencyIcon_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyIcon (icon: "coins/images/1/thumb/bitcoin.png")
    }
}

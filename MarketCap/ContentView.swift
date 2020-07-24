//
//  ContentView.swift
//  MarketCap
//
//  Created by Denis on 16.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

struct CurrencyList: View {
    
    @ObservedObject var loader = CurrencyLoader ()

    var body: some View {
        NavigationView {
            Group {
                if loader.currencies.count == 0 {
                    Loading ().frame (maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List (loader.currencies) {
                        CurrencyRow (currency: $0)
                    }
                }
            }
        }.frame (width: 400, height: 640)
    }
}

struct Loading: NSViewRepresentable {
    
    func makeNSView (context: NSViewRepresentableContext<Loading>) -> NSProgressIndicator {
        let result = NSProgressIndicator ()
        result.isIndeterminate = true
        result.startAnimation (nil)
        result.style = NSProgressIndicator.Style.spinning
    
        return result
    }
    
    func updateNSView(
        _ nsView: NSProgressIndicator,
        context: NSViewRepresentableContext<Loading>
    ) {

    }
}

struct CurrencyView: View {

    var currency: Currency

    var body: some View {
        VStack {
            CurrencyIcon (icon: currency.icon)
            Text (currency.name)
        }.frame (maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyList ()
    }
}

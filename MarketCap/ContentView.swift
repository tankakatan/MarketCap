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

struct CurrenciesView: View {
    
    var currencies: [Currency]

    var body: some View {
        ScrollView {
            if currencies.count == 0 {
                Group {
                    Loading ()
                }.frame (
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                ).background (Color.yellow)
            } else {
                VStack {
                    ForEach (currencies) {
                        CurrencyView (currency: $0)
                    }
                }.frame (
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                ).background (Color.green)
            }
        }.frame (
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).background (Color.red)
    }
}

struct CurrencyView: View {
    var currency: Currency
    var body: some View {
        HStack {
//            CurrencyIconView (url: currency.id)
            Text (currency.symbol)
            Text (currency.name)
        }
    }
}

struct CurrencyIconView: View {

    @ObservedObject private var loader: IconLoader
    private let placeholder: Image?

    init (url: String, placeholder: String = "icon-placeholder") {
        loader = try! IconLoader (url)
        self.placeholder = (Image (placeholder) as Image).scaledToFit () as? Image
    }
    
    var body: some View {
        image
            .onAppear (perform: loader.load)
            .onDisappear (perform: loader.cancel)
    }

    private var image: some View {
        placeholder
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView ()
    }
}

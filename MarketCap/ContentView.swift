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
        List (loader.currencies) {
            CurrencyView (currency: $0)
        }
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
        HStack {

            CurrencyIconView (icon: currency.icon)
                .aspectRatio (1.0, contentMode: .fit)
                .frame (width: 32, height: 32)
                .fixedSize (horizontal: true, vertical: false)
                .cornerRadius (4.0)

            Text (currency.symbol)
            Text (currency.name)
        }
    }
}

struct CurrencyIconView: View {

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView ()
    }
}

//
//  CurrencyLogoLoader.swift
//  MarketCap
//
//  Created by Denis on 01.08.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import Combine
import SwiftUI
import AppKit

public class CurrencyLogoLoader: ObservableObject {
    
    @Published var logo: Image?

    private var loading: AnyCancellable?
    private let source: String?
    
    init (_ url: String?) {
        source = url
    }
    
    deinit {
        cancel ()
    }
    
    public func load () {
        loading = URLSession.shared.dataTaskPublisher (for: URLComponents (string: source!)!.url!)
            .map { Image (nsImage: NSImage (data: $0.data) ?? NSImage ()) }
            .replaceError (with: nil)
            .receive (on: DispatchQueue.main)
            .assign (to: \.logo, on: self)
    }
    
    public func cancel () {
        loading?.cancel ()
    }
}

//
//  Loading.swift
//  MarketCap
//
//  Created by Denis on 24.07.2020.
//  Copyright © 2020 Denis Voropaev. All rights reserved.
//

import SwiftUI

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

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading ()
    }
}

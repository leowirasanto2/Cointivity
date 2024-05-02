//
//  ContentView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var path: [PathRoute] = []
    @State var toast: Toast?
    var body: some View {
        VStack {
            MarketListScreen(path: $path, toast: $toast)
                .environmentObject(MarketModel())
        }
        .toastView($toast)
    }
}

#Preview {
    ContentView()
}

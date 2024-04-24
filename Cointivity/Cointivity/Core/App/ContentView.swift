//
//  ContentView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MarketListScreen()
                .environmentObject(MarketModel())
        }
    }
}

#Preview {
    ContentView()
}

//
//  MarketListScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct MarketListScreen: View {
    @EnvironmentObject var model: MarketModel
    private var iconSize: CGFloat = 30
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(model.coins, id: \.id) { coin in
                    MarketItemView(coin: coin, iconSize: iconSize)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            Task {
                await model.fetchCoins()
            }
        }
    }
}

#Preview {
    MarketListScreen()
        .environmentObject(MarketModel())
}

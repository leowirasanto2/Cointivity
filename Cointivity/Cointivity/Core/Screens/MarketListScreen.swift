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
                HStack {
                    FilterButtonView(isActive: model.activeFilter == .rank, text: MarketFilterItem.rank.rawValue) {
                        if model.activeFilter == .rank {
                            model.activeFilter = .none
                        } else {
                            model.activeFilter = .rank
                        }
                    }
                    
                    FilterButtonView(isActive: model.activeFilter == .volume, text: MarketFilterItem.volume.rawValue) {
                        if model.activeFilter == .volume {
                            model.activeFilter = .none
                        } else {
                            model.activeFilter = .volume
                        }
                    }
                }
                .padding(.horizontal)
                ForEach(model.coins, id: \.id) { coin in
                    MarketItemView(coin: coin, iconSize: iconSize) { coin in
                        
                    }
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

//
//  CoinDetailScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import SwiftUI

struct CoinDetailScreen: View {
    @EnvironmentObject var model: ChartModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let coin = model.selectedCoin {
                    ChartView(dataPoints: model.priceDataPoint, coin: coin, selectedTimeFrame: $model.timeFrame)
                        .padding()
                    
                    Text("\(coin.name.orEmpty) Statistics")
                        .font(.headline)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CoinDetailScreen()
        .environmentObject(ChartModel(coin: .init(), path: .constant([])))
}

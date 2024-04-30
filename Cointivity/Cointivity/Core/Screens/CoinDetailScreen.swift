//
//  CoinDetailScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import SwiftUI

struct CoinDetailScreen: View {
    @EnvironmentObject var model: CoinDetailModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let coin = model.selectedCoin {
                    ChartView(dataPoints: model.priceDataPoint, coin: coin, selectedTimeFrame: $model.timeFrame)
                        .padding()
                    
                    Text("Statistics")
                        .font(.headline)
                    
                    Group {
                        Text("Info")
                            .font(.headline)
                        
                        InfoRowItemView(title: "Website", values: model.getWebsiteInfo(), onUrlSelected: model.openUrl)
                        InfoRowItemView(title: "Explorers", values: model.getExplorersInfo(), onUrlSelected: model.openUrl)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await model.fetchCoinDetail()
            }
        }
    }
}

#Preview {
    CoinDetailScreen()
        .environmentObject(CoinDetailModel(coin: .init(), path: .constant([])))
}

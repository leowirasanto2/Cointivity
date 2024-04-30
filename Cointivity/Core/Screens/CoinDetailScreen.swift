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
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .aspectRatio(0.7, contentMode: .fit)
                            .frame(height: 20)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 8)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await model.fetchCoinDetail()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .aspectRatio(0.9, contentMode: .fit)
                            .frame(height: 20)
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 8)
                }
                
                if let coin = model.selectedCoin {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            if let imageUrl = URL(string: coin.image.orEmpty) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(height: 30)
                                } placeholder: {
                                    Circle()
                                        .foregroundStyle(.gray.opacity(0.1))
                                        .frame(maxWidth: 30, maxHeight: 30)
                                }
                            }
                            
                            Text(coin.name.orEmpty)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text(coin.symbol.orEmpty.uppercased())
                                .font(.title3)
                                .foregroundStyle(.gray)
                                .fontWeight(.regular)
                            
                            Text("#\(coin.marketCapRank.orZero)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(8)
                                .background(.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Divider()
                        
                        HStack {
                            if let price = model.currentPriceDisplay {
                                Text(price)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            
                            if let changePercentage = model.latestPriceChangeDisplay {
                                Text(changePercentage)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(model.isPriceUp ? .green : .red)
                            }
                        }
                        
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.1), radius: 8)
                    
                    VStack(alignment: .leading) {
                        Text("Chart")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Divider()
                        
                        ChartView(dataPoints: model.priceDataPoint, coin: coin, selectedTimeFrame: $model.timeFrame)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.1), radius: 8)
                    
                    VStack(alignment: .leading) {
                        Text("Statistics")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Divider()
                        
                        if let info = model.marketCapInfo {
                            InfoRowItemView(title: "Market Cap", values: info, onUrlSelected: model.openUrl)
                        }
                        
                        if let info = model.fullyDilutedValuationInfo {
                            InfoRowItemView(title: "Fully Diluted Valuation", values: info, onUrlSelected: model.openUrl)
                        }
                        
                        if let info = model.volume {
                            InfoRowItemView(title: "Total Volume", values: info, onUrlSelected: model.openUrl)
                        }
                        
                        if let info = model.circulatingSupplyInfo {
                            InfoRowItemView(title: "Circulating Supply", values: info, onUrlSelected: model.openUrl)
                        }
                        
                        if let info = model.totalSupplyInfo {
                            InfoRowItemView(title: "Total Supply", values: info, onUrlSelected: model.openUrl)
                        }
                        
                        if let info = model.maxSupplyInfo {
                            InfoRowItemView(title: "Max Supply", values: info, onUrlSelected: model.openUrl)
                        }
                        //TODO: - content here
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.1), radius: 8)
                    
                    VStack(alignment: .leading) {
                        Text("Info")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Divider()
                        
                        if let info = model.getWebsiteInfo() {
                            InfoRowItemView(title: "Website", values: info, onUrlSelected: model.openUrl)
                        }
                        if let info = model.getExplorersInfo() {
                            InfoRowItemView(title: "Explorers", values: info, onUrlSelected: model.openUrl)
                        }
                        if let info = model.getWhitepaperInfo() {
                            InfoRowItemView(title: "Whitepaper", values: info, onUrlSelected: model.openUrl)
                        }
                        if let info = model.getRepoInfo() {
                            InfoRowItemView(title: "Repo", values: info, onUrlSelected: model.openUrl)
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.1), radius: 8)
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await model.fetchCoinDetail()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CoinDetailScreen()
        .environmentObject(CoinDetailModel(coin: .init(), path: .constant([])))
}

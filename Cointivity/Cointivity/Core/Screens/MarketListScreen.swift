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
    @State private var showAllList = false
    private let itemThreshold = 15
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    Text("Cointivity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.orange)
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(height: 20)
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
                Text("Crypto Market")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        StackCoinView(stackTitle: "🔥 Trending", imageUrls: model.trendingCoinIconPath()) {
                            //TODO: - go to trending list
                        }
                        
                        StackCoinView(stackTitle: "📈 Top Gainers", imageUrls: model.topGainerIconPath()) {
                            //TODO: - go to trending list
                        }
                        
                        StackCoinView(stackTitle: "📉 Top Losers", imageUrls: model.topLoserIconPath()) {
                            //TODO: - go to trending list
                        }
                    }
                    .padding()
                }
                .scrollTargetBehavior(.paging)
                
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
                ForEach(showAllList ? model.coins : Array(model.coins.prefix(itemThreshold)), id: \.id) { coin in
                    MarketItemView(coin: coin, iconSize: iconSize) { coin in
                        
                    }
                    .padding(.horizontal)
                }
                
                if !showAllList {
                    HStack(alignment: .center) {
                        Spacer()
                        Button {
                            showAllList.toggle()
                        } label: {
                            Text("Show more")
                                .foregroundStyle(.orange)
                                .fontWeight(.semibold)
                                .font(.headline)
                        }
                        Spacer()
                    }
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

//
//  MarketListScreen.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct MarketListScreen: View {
    @EnvironmentObject var model: MarketModel
    @State private var showAllList = false
    @State private var showFilterToolbar = false
    
    private var iconSize: CGFloat = 30
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
                    .padding(.horizontal)
                }
                .scrollClipDisabled()
                .scrollTargetBehavior(.paging)
                
                HStack(spacing: 16) {
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
                    
                    Spacer()
                    
                    FilterButtonView(isActive: isShortButtonActive(), text: "Sort", rightIcon: Image(systemName: "arrow.up.arrow.down")) {
                        showFilterToolbar.toggle()
                    }
                }
                .padding(.horizontal)
                
                ForEach(showAllList ? model.displayingCoins : Array(model.displayingCoins.prefix(itemThreshold)), id: \.id) { coin in
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
        .sheet(isPresented: $showFilterToolbar, content: {
            FilterScreen(activeFilter: $model.activeFilter)
                .presentationDetents([.medium])
        })
        .onAppear {
            Task {
                await model.fetchCoins()
            }
        }
    }
    
    private func isShortButtonActive() -> Bool {
        switch model.activeFilter {
        case .volume, .rank, .none:
            return false
        default:
            return true
        }
    }
}

#Preview {
    MarketListScreen()
        .environmentObject(MarketModel())
}

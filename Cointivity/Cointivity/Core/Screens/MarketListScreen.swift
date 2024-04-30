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
    @State private var iconSize: CGFloat = 30
    @Binding var path: [PathRoute]
    private let itemThreshold = 15
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    topSection
                    filterSection
                    marketListSection
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
            .navigationDestination(for: PathRoute.self) { selected in
                switch selected {
                case .searchScreen:
                    SearchMarketList(model: model, path: $path)
                case .detailScreen:
                    CoinDetailScreen()
                        .environmentObject(ChartModel(coin: model.selectedCoin, path: $path))
                default:
                    Text("Coming soon")
                }
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
    
    private var titleSection: some View {
        ZStack(alignment: .centerFirstTextBaseline) {
            Text("Cointivity")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.orange)
                .frame(maxWidth: .infinity)
            HStack(alignment: .center) {
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
                
                Button {
                    model.isEditingWatchList.toggle()
                } label: {
                    Image(systemName: model.isEditingWatchList ? "star.fill" : "star")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 20)
                        .foregroundStyle(.black)
                }
                
                Button {
                    path = [.searchScreen]
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 20)
                        .foregroundStyle(.black)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var topSection: some View {
        VStack(alignment: .leading) {
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
        }
    }
    
    private var filterSection: some View {
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
    }
    
    private var marketListSection: some View {
        Group {
            ForEach(showAllList ? model.displayingCoins : Array(model.displayingCoins.prefix(itemThreshold)), id: \.id) { coin in
                Button {
                    if model.isEditingWatchList {
                        model.selectToEditAction(coin)
                    } else {
                        model.selectedCoin = coin
                        path.append(.detailScreen)
                    }
                } label: {
                    MarketItemView(coin: coin, iconSize: iconSize, selectionMode: model.isEditingWatchList, isSelected: model.isCoinSelected(coin))
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
}

#Preview {
    MarketListScreen(path: .constant([]))
        .environmentObject(MarketModel())
}

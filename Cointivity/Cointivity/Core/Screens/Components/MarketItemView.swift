//
//  MarketItem.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct MarketItemView: View {
    var coin: Coin
    var iconSize: CGFloat = 30
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Text("\(coin.marketCapRank.orZero)")
                .font(.headline)
                .foregroundStyle(.gray)
            
            if let imageUrl = URL(string: coin.image.orEmpty) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(coin.name.orEmpty)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text(coin.symbol.orEmpty)
                    .textCase(.uppercase)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            priceView
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
    
    private var priceView: some View {
        let toPercent = coin.priceChangePercentage24H.orZero * 100
        let priceChangeDisplay = "\(coin.priceChange24H.orZero)" + "(\(toPercent)%)"
        let currentPriceDisplay = "$\(coin.currentPrice.orZero)"
        let color: Color = toPercent >= 0 ? .green : .red
        
        return VStack(alignment: .trailing, spacing: 8) {
            Text(currentPriceDisplay)
                .font(.headline)
                .foregroundStyle(.black)
            Text(priceChangeDisplay)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    MarketItemView(coin: Coin(id: "", symbol: "BTC", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 0.11, marketCap: 123, marketCapRank: 1, fullyDilutedValuation: 3123.12, totalVolume: 1, high24H: 12312.12, low24H: 123123.1, priceChange24H: -123123.1, priceChangePercentage24H: -3123.1, marketCapChange24H: nil, marketCapChangePercentage24H: nil, circulatingSupply: nil, totalSupply: nil, maxSupply: nil, ath: nil, athChangePercentage: nil, athDate: nil, atl: nil, atlChangePercentage: nil, atlDate: nil, roi: nil, lastUpdated: nil))
}

//
//  TrendingStackView.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import SwiftUI

struct StackCoinView: View {
    var stackTitle: String?
    var imageUrls: [String] = []
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title = stackTitle {
                Button(action: action, label: {
                    HStack(alignment: .center) {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(0.5, contentMode: .fit)
                            .frame(height: 10)
                    }
                    .foregroundStyle(.black)
                })
            }
            HStack(spacing: -8) {
                ForEach(imageUrls, id: \.self) { path in
                    StackCoinItemView(imageUrl: URL(string: path))
                }
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 8)
    }
}

#Preview {
    StackCoinView(
        stackTitle: "🔥 Trending coins",
        imageUrls: [
        "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
        "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        "https://assets.coingecko.com/coins/images/325/large/Tether.png?1696501661",
        "https://assets.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970",
        "https://assets.coingecko.com/coins/images/4128/large/solana.png?1696504756",
        "https://assets.coingecko.com/coins/images/6319/large/usdc.png?1696506694"
        ]) {}
}

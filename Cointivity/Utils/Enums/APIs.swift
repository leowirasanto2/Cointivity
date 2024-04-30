//
//  APIs.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 01/05/24.
//

import Foundation

enum APIs {
    case marketList
    case coinDetail(coinId: String)
    case chart(coinId: String)
    
    private var baseURL: URL {
        URL(string: "https://api.coingecko.com/api/v3/coins")!
    }
    
    var url: URL {
        switch self {
        case .marketList:
            baseURL.appending(path: "/markets")
        case .coinDetail(let coinId):
            baseURL.appending(path: "/\(coinId)")
        case .chart(let coinId):
            baseURL.appending(path: "/\(coinId)/market_chart")
        }
    }
}

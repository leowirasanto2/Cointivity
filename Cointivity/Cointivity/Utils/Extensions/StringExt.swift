//
//  StringExt.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}

extension String {
    static let coinGeckoImageUrl = "https://static.coingecko.com/s/coingecko-logo-8903d34ce19ca4be1c81f0db30e924154750d208683fad7ae6f2ce06c76d0a56.png"
    
    var urlComp: URLComponents? {
        return URLComponents(string: self)
    }
}

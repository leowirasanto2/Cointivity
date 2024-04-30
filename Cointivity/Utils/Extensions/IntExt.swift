//
//  IntExt.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

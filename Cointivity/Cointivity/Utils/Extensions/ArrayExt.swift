//
//  ArrayExt.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 30/04/24.
//

import Foundation

extension Array {
    var orNil: [Element]? {
        if self.isEmpty {
            return nil
        } else {
            return self
        }
    }
}

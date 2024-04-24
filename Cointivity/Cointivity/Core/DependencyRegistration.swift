//
//  DependencyRegistration.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation
import Dependencies

extension DependencyValues {
    var dummyJsonService: DummyJsonService {
        get { self[DummyJsonServiceKey.self] }
        set { self[DummyJsonServiceKey.self] = newValue }
    }
    
    var httpClientService: HttpClientService {
        get { self[HttpClientServiceKey.self] }
        set { self[HttpClientServiceKey.self] = newValue }
    }
}

private struct DummyJsonServiceKey: DependencyKey {
    static var liveValue: DummyJsonService = DummyJsonImplementation()
}

private struct HttpClientServiceKey: DependencyKey {
    static var liveValue: HttpClientService = HttpClientImp()
}

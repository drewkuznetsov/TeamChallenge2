//
//  LoadingState.swift
//  TeamChallenge2
//
//  Created by lorenc_D_K on 05.03.2025.
//

import Foundation
import ShoppeStore

enum LoadingState: Error {
    case loading
    case loaded([Category])
    case error(Error)
    
//    init(_ result: Result<[Product], Error>) {
//        switch result {
//        case .success(let success):
//            self = .loaded(success)
//        case .failure(let failure):
//            self = .error(failure)
//        }
//    }
}

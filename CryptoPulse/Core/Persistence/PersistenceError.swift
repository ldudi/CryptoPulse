//
//  PersistenceError.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//
//  PersistenceError.swift
//  CryptoPulse
//

import Foundation

enum PersistenceError: LocalizedError {

    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
    case updateFailed(Error)

    var errorDescription: String? {

        switch self {

        case .saveFailed(let error):
            return "Failed to save data: \(error.localizedDescription)"

        case .fetchFailed(let error):
            return "Failed to fetch data: \(error.localizedDescription)"

        case .deleteFailed(let error):
            return "Failed to delete data: \(error.localizedDescription)"

        case .updateFailed(let error):
            return "Failed to update data: \(error.localizedDescription)"
        }
    }
}

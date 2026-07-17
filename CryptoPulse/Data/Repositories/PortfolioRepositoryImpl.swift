//
//  PortfolioRepositoryImpl.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  PortfolioRepositoryImpl.swift
//  CryptoPulse
//

import Foundation
import SwiftData

@MainActor
final class PortfolioRepositoryImpl: PortfolioRepository {

    private let persistence: PersistenceController

    private var context: ModelContext {
        persistence.context
    }

    init(
        persistence: PersistenceController
    ) {
        self.persistence = persistence
    }

    func holdings() async throws -> [PortfolioHolding] {

        do {

            let descriptor = FetchDescriptor<PortfolioHoldingEntity>()

            let entities = try context.fetch(descriptor)

            return entities.map(
                PortfolioHoldingMapper.toDomain
            )

        } catch {

            throw PersistenceError.fetchFailed(error)
        }
    }

    func holding(
        for coinID: String
    ) async throws -> PortfolioHolding? {

        do {

            let descriptor = FetchDescriptor<PortfolioHoldingEntity>(
                predicate: #Predicate {
                    $0.coinID == coinID
                }
            )

            return try context
                .fetch(descriptor)
                .first
                .map(PortfolioHoldingMapper.toDomain)

        } catch {

            throw PersistenceError.fetchFailed(error)
        }
    }

    func insert(
        _ holding: PortfolioHolding
    ) async throws {

        context.insert(
            PortfolioHoldingMapper.toEntity(
                holding
            )
        )

        try persistence.save()
    }
    
    func update(
        _ holding: PortfolioHolding
    ) async throws {

        do {

            let coinID = holding.coinID

            let descriptor = FetchDescriptor<PortfolioHoldingEntity>(
                predicate: #Predicate {
                    $0.coinID == coinID
                }
            )

            guard let entity = try context.fetch(descriptor).first else {
                return
            }

            entity.quantity = holding.quantity
            entity.name = holding.name
            entity.symbol = holding.symbol
            entity.imageURL = holding.imageURL?.absoluteString

            try persistence.save()

        } catch {

            throw PersistenceError.updateFailed(error)
        }
    }

    func delete(
        coinID: String
    ) async throws {

        let descriptor = FetchDescriptor<PortfolioHoldingEntity>(
            predicate: #Predicate {
                $0.coinID == coinID
            }
        )

        guard let entity = try context.fetch(descriptor).first else {
            return
        }

        context.delete(entity)

        try persistence.save()
    }
}

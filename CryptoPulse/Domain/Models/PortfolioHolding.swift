import Foundation

/// A domain model representing a user's portfolio holding.
struct PortfolioHolding: Identifiable, Equatable, Sendable {
    
    // MARK: - Identification
    
    var id: String {
        coinID
    }
    
    // MARK: - Holding information
    
    let coinID: String
    let symbol: String
    let name: String
    let imageURL: URL?
    let quantity: Double
    let averageBuyPrice: Double  // New property for tracking buy price
    
    // MARK: - Initializer
    
    init(
        coinID: String,
        symbol: String,
        name: String,
        imageURL: URL?,
        quantity: Double,
        averageBuyPrice: Double = 0.0
    ) {
        self.coinID = coinID
        self.symbol = symbol
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
        self.averageBuyPrice = averageBuyPrice
    }
}

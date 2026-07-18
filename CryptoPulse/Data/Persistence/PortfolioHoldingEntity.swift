import Foundation
import SwiftData

@Model
final class PortfolioHoldingEntity {
    
    // MARK: - Properties
    
    var coinID: String
    var symbol: String
    var name: String
    var imageURL: String?
    var quantity: Double
    var averageBuyPrice: Double  // New property for tracking buy price
    
    // MARK: - Init
    
    init(
        coinID: String,
        symbol: String,
        name: String,
        imageURL: String?,
        quantity: Double,
        averageBuyPrice: Double = 0.0  // Default to 0.0 for existing holdings
    ) {
        self.coinID = coinID
        self.symbol = symbol
        self.name = name
        self.imageURL = imageURL
        self.quantity = quantity
        self.averageBuyPrice = averageBuyPrice
    }
}

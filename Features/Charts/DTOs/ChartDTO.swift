import Foundation

struct ChartDTO: Decodable {
    let prices: [PricePointDTO]
    
    struct PricePointDTO: Decodable {
        let timestamp: Double
        let price: Double
        
        enum CodingKeys: String, CodingKey {
            case timestamp = "timestamp"
            case price = "price"
        }
    }
}

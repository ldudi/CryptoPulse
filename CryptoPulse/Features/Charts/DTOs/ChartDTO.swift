import Foundation

struct ChartDTO: Decodable {
    let prices: [PricePointDTO]

    struct PricePointDTO: Decodable {
        let timestamp: Double
        let price: Double

        init(from decoder: Decoder) throws {
            var container = try decoder.unkeyedContainer()

            timestamp = try container.decode(Double.self)
            price = try container.decode(Double.self)
        }
    }
}

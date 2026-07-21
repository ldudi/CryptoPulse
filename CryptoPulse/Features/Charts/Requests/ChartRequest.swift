import Foundation

struct ChartRequest {
    let coinId: String
    let currency: Currency = .usd
    let days: String = "30"
    
    enum Currency: String {
        case usd = "usd"
        case eur = "eur"
        case gbp = "gbp"
        case inr = "inr"
    }
}

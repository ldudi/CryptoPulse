import Foundation

struct ChartDataPoint: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let price: Double
}

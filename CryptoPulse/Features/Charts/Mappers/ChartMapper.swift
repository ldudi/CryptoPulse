import Foundation

extension ChartDTO {
    func toChartDataPoints() -> [ChartDataPoint] {
        return prices.map { pricePoint in
            ChartDataPoint(
                date: Date(timeIntervalSince1970: pricePoint.timestamp / 1000),
                price: pricePoint.price
            )
        }
    }
}

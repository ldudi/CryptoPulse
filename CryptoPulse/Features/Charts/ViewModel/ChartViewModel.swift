import Foundation
import SwiftUI
import Observation

@MainActor
@Observable
final class ChartViewModel {
    // MARK: - State
    var state: ChartState = .idle
    var dataPoints: [ChartDataPoint] = []
    var selectedRange: ChartTimeRange = .day30
    var selectedPoint: ChartDataPoint?
    var isLoading = false
    var errorMessage: String?
    
    // Data for the header
    var currentPrice: Double?
    var priceChange: Double?
    var priceChangePercentage: Double?
    var selectedPrice: Double?
    var selectedDate: String?
    
    private let getChartDataUseCase: GetChartDataUseCase
    private let coinId: String
    private var fetchTask: Task<Void, Never>?

    enum ChartState: Equatable {
        case idle
        case loading
        case loaded
        case empty
        case error(String)
    }

    init(coinId: String, getChartDataUseCase: GetChartDataUseCase) {
        self.coinId = coinId
        self.getChartDataUseCase = getChartDataUseCase
    }

    // MARK: - Public API (matching ChartContainerView expectations)
    
    var chartDataPoints: [ChartDataPoint] {
        dataPoints
    }
    
    var selectedTimeRange: ChartTimeRange {
        get { selectedRange }
        set { selectedRange = newValue }
    }
    
    func loadChart() async {
        await loadData()
    }
    
    func loadChart(for range: ChartTimeRange) async {
        selectedRange = range
        await loadData()
    }

    // MARK: - Internal Implementation
    
    func loadData() async {
        fetchTask?.cancel()
        
        isLoading = true
        errorMessage = nil
        state = .loading
        
        fetchTask = Task {
            do {
                let points = try await getChartDataUseCase.execute(
                    coinId: coinId,
                    range: selectedRange
                )
                
                if Task.isCancelled { return }
                
                if points.isEmpty {
                    state = .empty
                    dataPoints = []
                    currentPrice = nil
                    priceChange = nil
                    priceChangePercentage = nil
                } else {
                    self.dataPoints = points
                    state = .loaded
                    updatePriceInfo(from: points)
                }
            } catch {
                if Task.isCancelled { return }
                state = .error(error.localizedDescription)
                errorMessage = error.localizedDescription
                dataPoints = []
                currentPrice = nil
                priceChange = nil
                priceChangePercentage = nil
            }
            
            isLoading = false
        }
        
        await fetchTask?.value
    }

    func updateRange(_ range: ChartTimeRange) {
        selectedRange = range
        Task {
            await loadData()
        }
    }

    func handleDrag(date: Date) {
        // Find the point closest to the dragged date
        let closest = dataPoints.min(by: { 
            abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) 
        })
        
        if let closest, abs(closest.date.timeIntervalSince(date)) < 86400 * 2 { // 2 day threshold
            selectedPoint = closest
            selectedPrice = closest.price
            selectedDate = formatDate(closest.date)
        } else {
            selectedPoint = nil
            selectedPrice = nil
            selectedDate = nil
        }
    }

    func clearSelection() {
        selectedPoint = nil
        selectedPrice = nil
        selectedDate = nil
    }
    
    // MARK: - Helpers
    
    private func updatePriceInfo(from points: [ChartDataPoint]) {
        guard let last = points.last, let first = points.first else { return }
        
        currentPrice = last.price
        priceChange = last.price - first.price
        priceChangePercentage = first.price != 0 ? ((last.price - first.price) / first.price) * 100 : 0
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

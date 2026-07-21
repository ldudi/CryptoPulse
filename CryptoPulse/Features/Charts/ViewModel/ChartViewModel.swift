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

    func loadData() async {
        fetchTask?.cancel()
        
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
                } else {
                    self.dataPoints = points
                    state = .loaded
                }
            } catch {
                if Task.isCancelled { return }
                state = .error(error.localizedDescription)
            }
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
        } else {
            selectedPoint = nil
        }
    }

    func clearSelection() {
        selectedPoint = nil
    }
}

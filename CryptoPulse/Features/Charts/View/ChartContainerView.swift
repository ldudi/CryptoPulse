import SwiftUI
import Charts

struct ChartContainerView: View {
    @State private var viewModel: ChartViewModel
    @State private var isDragging = false
    
    init(viewModel: ChartViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            // Price header
            SelectedPriceView(
                isDragging: isDragging,
                selectedPrice: viewModel.selectedPrice,
                selectedDate: viewModel.selectedDate,
                currentPrice: viewModel.currentPrice,
                priceChange: viewModel.priceChange,
                priceChangePercentage: viewModel.priceChangePercentage
            )
            
            // Chart area
            ZStack {
                if let errorMessage = viewModel.errorMessage {
                    ChartErrorView(
                        message: errorMessage,
                        onRetry: {
                            Task {
                                await viewModel.loadChart()
                            }
                        }
                    )
                } else if viewModel.chartDataPoints.isEmpty {
                    ChartEmptyView()
                } else {
                    PriceChartView(
                        dataPoints: viewModel.chartDataPoints,
                        selectedPoint: $viewModel.selectedPoint,
                        isDragging: $isDragging
                    )
                    .frame(minHeight: 200)
                }
                
                if viewModel.isLoading {
                    ChartLoadingView()
                }
            }
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: viewModel.isLoading)
            
            // Time range picker
            TimeRangePicker(
                selectedRange: $viewModel.selectedTimeRange,
                onRangeSelected: { range in
                    Task {
                        await viewModel.loadChart(for: range)
                    }
                }
            )
        }
        .padding(.horizontal, Spacing.medium)
        .task {
            await viewModel.loadChart()
        }
    }
}

import SwiftUI
import Charts
import Observation

struct ChartContainerView: View {

    @Bindable var viewModel: ChartViewModel

    @State
    private var isDragging = false

    var body: some View {

        VStack(alignment: .leading, spacing: Spacing.medium) {

            SelectedPriceView(
                isDragging: isDragging,
                selectedPrice: viewModel.selectedPrice,
                selectedDate: viewModel.selectedDate,
                currentPrice: viewModel.currentPrice,
                priceChange: viewModel.priceChange,
                priceChangePercentage: viewModel.priceChangePercentage
            )

            chartContent

            ChartTimeRangePicker(
                selectedRange: $viewModel.selectedTimeRange
            ) { range in

                Task {
                    await viewModel.loadChart(for: range)
                }

            }
        }
        .padding(Spacing.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(
                cornerRadius: Radius.large,
                style: .continuous
            )
            .fill(AppColors.secondaryBackground)
        )
        .overlay(
            RoundedRectangle(
                cornerRadius: Radius.large,
                style: .continuous
            )
            .strokeBorder(
                Color.primary.opacity(0.06),
                lineWidth: 1
            )
        )
        .appShadow(AppShadows.medium)
        .task {
            if viewModel.chartDataPoints.isEmpty {
                await viewModel.loadChart()
            }
        }
        .animation(.snappy, value: viewModel.selectedTimeRange)
        .animation(.snappy, value: viewModel.chartDataPoints)
        .animation(.snappy, value: viewModel.isLoading)
    }
}

// MARK: - Chart Content

private extension ChartContainerView {

    @ViewBuilder
    var chartContent: some View {

        ZStack {
            
            if viewModel.isLoading {
                
                ChartLoadingView()
                    .transition(.opacity)

            } else if let error = viewModel.errorMessage {

                ChartErrorView(
                    message: error
                ) {
                    Task {
                        await viewModel.loadChart()
                    }
                }

            } else if viewModel.chartDataPoints.isEmpty {

                ChartEmptyView()

            } else {

                PriceChartView(
                    dataPoints: viewModel.chartDataPoints,
                    selectedPoint: $viewModel.selectedPoint,
                    isDragging: $isDragging
                )
                .frame(height: 240)
                .contentTransition(.interpolate)

            }

            

        }
        .frame(height: 240)
    }

}

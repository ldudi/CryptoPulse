import SwiftUI
import Charts

struct ChartView: View {
    @State var viewModel: ChartViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with Price and Date
            HStack(alignment: .firstTextBaseline) {
                if let selected = viewModel.selectedPoint {
                    Text(selected.price, format: .currency(code: "USD"))
                        .font(Typography.title2)
                        .bold()
                    
                    Text(selected.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("Drag to explore")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Chart Area
            ZStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .empty:
                    ContentUnavailableView("No Data", systemImage: "chart.line.downtrend.xyaxis")
                case .error(let message):
                    VStack {
                        Text(message).foregroundColor(.red)
                        Button("Retry") { Task { await viewModel.loadData() } }
                    }
                case .loaded, .idle:
                    chartContent
                }
            }
            .frame(height: 250)

            // Range Picker
            ChartTimeRangePicker(
                selectedRange: Binding(
                    get: { viewModel.selectedRange },
                    set: { _ in }
                ),
                onRangeChanged: { range in
                    viewModel.updateRange(range)
                }
            )
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .cornerRadius(Radius.medium)
    }

    private var chartContent: some View {
        Chart {
            ForEach(viewModel.dataPoints) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Price", point.price)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.accentColor)
            }

            if let selected = viewModel.selectedPoint {
                RuleMark(x: .value("Selected Date", selected.date))
                    .foregroundStyle(.secondary)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))

                PointMark(
                    x: .value("Selected Date", selected.date),
                    y: .value("Price", selected.price)
                )
                .foregroundStyle(AppColors.accent)
                .symbolSize(100)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.day().month())
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartYScale(domain: .automatic(includesZero: false))
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let date = proxy.value(atX: value.location.x, as: Date.self)
                                if let date = date {
                                    viewModel.handleDrag(date: date)
                                }
                            }
                            .onEnded { _ in
                                viewModel.clearSelection()
                            }
                    )
            }
        }
    }
}

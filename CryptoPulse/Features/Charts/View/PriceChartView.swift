import SwiftUI
import Charts

struct PriceChartView: View {
    let dataPoints: [ChartDataPoint]
    @Binding var selectedPoint: ChartDataPoint?
    @Binding var isDragging: Bool
    
    var body: some View {
        Chart {
            ForEach(dataPoints) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Price", point.price)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(Color.accentColor)
                
                if let selectedPoint = selectedPoint,
                   point.id == selectedPoint.id {
                    PointMark(
                        x: .value("Date", point.date),
                        y: .value("Price", point.price)
                    )
                    .symbolSize(80)
                    .foregroundStyle(Color.accentColor)
                    
                    RuleMark(x: .value("Date", point.date))
                        .foregroundStyle(Color.secondary.opacity(0.3))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisGridLine()
                    .foregroundStyle(Color.secondary.opacity(0.1))
                AxisTick()
            }
            .chartYAxisLabel(position: .leading) {
                Text("Price")
                    .font(Typography.caption)
                    .foregroundStyle(Color.secondary)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: getXAxisStride())) { _ in
                AxisGridLine()
                    .foregroundStyle(Color.secondary.opacity(0.1))
                AxisValueLabel(format: .dateTime.week())
                    .font(Typography.caption2)
                    .foregroundStyle(Color.secondary)
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                isDragging = true
                                if let date = proxy.value(atX: value.location.x) as Date? {
                                    updateSelectedPoint(at: date, proxy: proxy)
                                }
                            }
                            .onEnded { _ in
                                isDragging = false
                                selectedPoint = nil
                            }
                    )
            }
        }
        .animation(.easeInOut, value: dataPoints)
    }
    
    private func getXAxisStride() -> Int {
        guard let minDate = dataPoints.min(by: { $0.date < $1.date })?.date,
              let maxDate = dataPoints.max(by: { $0.date < $1.date })?.date else {
            return 1
        }
        
        let days = Calendar.current.dateComponents([.day], from: minDate, to: maxDate).day ?? 1
        return max(1, days / 5)
    }
    
    private func updateSelectedPoint(at date: Date, proxy: ChartProxy) {
        let dates = dataPoints.map { $0.date }
        let closestIndex = dates.enumerated().min { abs($0.element.timeIntervalSince(date)) < abs($1.element.timeIntervalSince(date)) }?.offset
        
        if let index = closestIndex {
            selectedPoint = dataPoints[index]
        }
    }
}

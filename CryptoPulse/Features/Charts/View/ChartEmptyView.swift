import SwiftUI

struct ChartEmptyView: View {
    var body: some View {
        VStack(spacing: Spacing.small) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.largeTitle)
                .foregroundStyle(Color.secondary)
            
            Text("No chart data available")
                .font(Typography.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color.secondary.opacity(0.05))
        .cornerRadius(Radius.medium)
    }
}

import SwiftUI

struct ChartTimeRangePicker: View {
    @Binding var selectedRange: ChartTimeRange
    let onRangeChanged: (ChartTimeRange) -> Void

    var body: some View {
        HStack(spacing: 8) {
            ForEach(ChartTimeRange.allCases, id: \.self) { range in
                Button {
                    selectedRange = range
                    onRangeChanged(range)
                } label: {
                    Text(range.title)
                        .font(.caption.weight(.medium))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(selectedRange == range ? Color.accentColor : Color.secondary.opacity(0.2))
                        .foregroundColor(selectedRange == range ? .white : .primary)
                        .cornerRadius(Radius.small)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 8)
    }
}

import SwiftUI

struct TimeRangePicker: View {
    @Binding var selectedRange: ChartTimeRange
    let onRangeSelected: (ChartTimeRange) -> Void
    
    private let ranges: [ChartTimeRange] = [.day1, .day7, .day30, .day90, .year1, .max]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.xSmall) {
                ForEach(ranges, id: \.self) { range in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedRange = range
                            onRangeSelected(range)
                        }
                    }) {
                        Text(range.title)
                            .font(Typography.subheadline)
                            .fontWeight(selectedRange == range ? .semibold : .regular)
                            .foregroundColor(selectedRange == range ? Color.primary : Color.secondary)
                            .padding(.horizontal, Spacing.small)
                            .padding(.vertical, Spacing.xxSmall)
                            .background(
                                RoundedRectangle(cornerRadius: Radius.small)
                                    .fill(selectedRange == range ? Color.accentColor.opacity(0.2) : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Select \(range.title) range")
                    .accessibilityValue(selectedRange == range ? "Selected" : "Not selected")
                }
            }
            .padding(.vertical, Spacing.xxSmall)
        }
    }
}

import SwiftUI

struct DetailRow: View {

    let title: String
    let value: String

    var valueColor: Color = .primary

    var body: some View {
        HStack(alignment: .firstTextBaseline) {

            Text(title)
                .foregroundStyle(.secondary)

            Spacer(minLength: 16)

            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack(spacing: 12) {
        DetailRow(
            title: "Current Price",
            value: "$118,423.21"
        )

        DetailRow(
            title: "24h Change",
            value: "+4.62%",
            valueColor: .green
        )

        DetailRow(
            title: "Market Cap",
            value: "$2.34T"
        )

        DetailRow(
            title: "24h Volume",
            value: "$84.7B"
        )
    }
    .padding()
}

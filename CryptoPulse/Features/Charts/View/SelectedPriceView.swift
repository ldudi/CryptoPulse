import SwiftUI

struct SelectedPriceView: View {
    let isDragging: Bool
    let selectedPrice: Double?
    let selectedDate: String?
    let currentPrice: Double?
    let priceChange: Double?
    let priceChangePercentage: Double?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xxxSmall) {
            if isDragging, let price = selectedPrice {
                Text("Selected Price")
                    .font(Typography.caption)
                    .foregroundStyle(Color.secondary)
                
                Text("$\(price, specifier: "%.2f")")
                    .font(Typography.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.primary)
                
                if let date = selectedDate {
                    Text(date)
                        .font(Typography.caption)
                        .foregroundStyle(Color.secondary)
                }
            } else {
                Text("Current Price")
                    .font(Typography.caption)
                    .foregroundStyle(Color.secondary)
                
                if let price = currentPrice {
                    Text("$\(price, specifier: "%.2f")")
                        .font(Typography.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primary)
                }
                
                if let change = priceChange,
                   let percentage = priceChangePercentage {
                    HStack(spacing: Spacing.xxxSmall) {
                        Text("$\(change, specifier: "%.2f")")
                            .font(Typography.subheadline)
                            .foregroundStyle(change >= 0 ? Color.green : Color.red)
                        
                        Text("(\(percentage, specifier: "%.2f")%)")
                            .font(Typography.subheadline)
                            .foregroundStyle(change >= 0 ? Color.green : Color.red)
                    }
                }
            }
        }
        .animation(.easeInOut, value: isDragging)
        .animation(.easeInOut, value: selectedPrice)
    }
}

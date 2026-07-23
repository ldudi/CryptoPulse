import SwiftUI

struct PortfolioSummaryView: View {
    
    let state: PortfolioState
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text("Total Value")
                .font(.headline)
            
            Text(state.totalValue, format: .currency(code: "USD"))
                .font(.title)
                .fontWeight(.bold)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xSmall) {
                    Text("Assets")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(state.assetCount)")
                        .font(.headline)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: Spacing.xSmall) {
                    Text("Coins")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(state.totalCoins, specifier: "%.4f")")
                        .font(.headline)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: Spacing.xSmall) {
                    Text("Largest Holding")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if let largestHolding = state.largestHolding {
                        Text(largestHolding.allocationPercentage.formatted(.percent))
                            .font(.headline)
                    } else {
                        Text("--")
                            .font(.headline)
                    }
                }
            }
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .cornerRadius(Spacing.small)
        .appShadow(AppShadows.medium)
    }
}

import SwiftUI

struct PortfolioRowView: View {
    
    let asset: PortfolioAsset
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: Spacing.medium) {
            AsyncImage(url: asset.imageURL) { phase in
                switch phase {
                case .empty:
                    Image(systemName: AppIcon.bitcoin)
                        .foregroundColor(.secondary)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: AppIcon.bitcoin)
                        .foregroundColor(.secondary)
                @unknown default:
                    Image(systemName: AppIcon.bitcoin)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: Spacing.xSmall) {
                Text(asset.name)
                    .font(.headline)
                
                HStack {
                    Text(asset.symbol)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(asset.quantity, specifier: "%.4f")")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text(asset.currentPrice, format: .currency(code: "USD"))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(asset.currentPrice, format: .currency(code: "USD"))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text("Allocation: \(asset.allocationPercentage, format: .percent)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let change = asset.priceChange24H {
                        Text(change, format: .percent)
                            .font(.caption)
                            .foregroundColor(change >= 0 ? .green : .red)
                    }
                }
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: AppIcon.trash)
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, Spacing.small)
    }
}

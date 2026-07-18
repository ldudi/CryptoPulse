import SwiftUI

struct PortfolioRowView: View {

    let asset: PortfolioAsset
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: Spacing.medium) {
            AsyncImage(url: asset.imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 32, height: 32)
                case .success(let image):
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 32, height: 32)
                case .failure:
                    Image(systemName: AppIcon.error)
                        .foregroundColor(AppColors.warning)
                        .frame(width: 32, height: 32)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: Spacing.xSmall) {
                Text(asset.name)
                    .font(.headline)
                Text(asset.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(AppColors.secondaryText)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: Spacing.xSmall) {
                Text("$\(asset.currentValue, specifier: "%.2f")")
                    .font(.body)
                if let change = asset.priceChange24H {
                    Text("\(change >= 0 ? "+" : "")\(change, specifier: "%.2f")%")
                        .font(.caption)
                        .foregroundColor(change >= 0 ? AppColors.success : AppColors.warning)
                }
            }

            Button(role: .destructive, action: onDelete) {
                Image(systemName: AppIcon.trash)
                    .foregroundColor(AppColors.error)
            }
        }
        .padding(.vertical, Spacing.small)
    }
}

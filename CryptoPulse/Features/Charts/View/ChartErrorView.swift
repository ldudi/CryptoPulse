import SwiftUI

struct ChartErrorView: View {
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: Spacing.small) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(Color.orange)
            
            Text(message)
                .font(Typography.subheadline)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: onRetry) {
                Text("Retry")
                    .font(Typography.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, Spacing.medium)
                    .padding(.vertical, Spacing.xxSmall)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(Radius.pill)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.horizontal, Spacing.large)
    }
}

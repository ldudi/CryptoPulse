import SwiftUI

struct ChartLoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.2)
            
            Text("Loading chart data...")
                .font(Typography.caption)
                .foregroundStyle(Color.secondary)
                .padding(.top, Spacing.xxxSmall)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondary.opacity(0.05))
        .cornerRadius(Radius.medium)
    }
}

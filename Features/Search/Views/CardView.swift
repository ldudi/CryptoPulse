import SwiftUI

struct CardView<Content>: View where Content: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .background(Color.secondarySystemBackground)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

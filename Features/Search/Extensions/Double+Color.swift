import SwiftUI

extension Double {
    var priceChangeColor: Color {
        return self >= 0 ? .green : .red
    }
}

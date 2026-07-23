import SwiftUI

struct HoldingEditorView: View {
    
    @Binding var quantity: Double?
    @Binding var averageBuyPrice: Double?
    let onSave: (Double, Double) -> Void
    let onCancel: () -> Void
    
    @State private var inputQuantity: String = ""
    @State private var inputAverageBuyPrice: String = ""
    
    init(
        quantity: Binding<Double?>,
        averageBuyPrice: Binding<Double?>,
        onSave: @escaping (Double, Double) -> Void,
        onCancel: @escaping () -> Void
    ) {
        self._quantity = quantity
        self._averageBuyPrice = averageBuyPrice
        self.onSave = onSave
        self.onCancel = onCancel
        
        if let quantityValue = quantity.wrappedValue {
            self._inputQuantity = State(initialValue: String(format: "%.4f", quantityValue))
        }
        
        if let buyPriceValue = averageBuyPrice.wrappedValue {
            self._inputAverageBuyPrice = State(initialValue: String(format: "%.2f", buyPriceValue))
        }
    }
    
    var body: some View {
        VStack(spacing: Spacing.medium) {
            Text("Edit Holding")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: Spacing.small) {
                Text("Quantity")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("Enter quantity", text: $inputQuantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            VStack(alignment: .leading, spacing: Spacing.small) {
                Text("Average Buy Price")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("Enter buy price", text: $inputAverageBuyPrice)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                .foregroundColor(.primary)
                
                Spacer()
                
                Button("Save") {
                    guard let quantityValue = Double(inputQuantity),
                          let buyPriceValue = Double(inputAverageBuyPrice) else {
                        return
                    }
                    
                    onSave(quantityValue, buyPriceValue)
                }
                .disabled(inputQuantity.isEmpty || inputAverageBuyPrice.isEmpty)
                .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

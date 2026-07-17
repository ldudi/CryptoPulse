import SwiftUI

struct HoldingEditorView: View {

    @Binding var quantity: Double?
    let onSave: (Double) -> Void
    let onCancel: () -> Void

    @State private var inputText: String = ""

    init(
        quantity: Binding<Double?>,
        onSave: @escaping (Double) -> Void,
        onCancel: @escaping () -> Void
    ) {
        self._quantity = quantity
        self.onSave = onSave
        self.onCancel = onCancel

        if let q = quantity.wrappedValue {
            _inputText = State(initialValue: String(q))
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Quantity")) {
                    TextField("Enter quantity", text: $inputText)
                        .keyboardType(.decimalPad)
                        .onChange(of: inputText) { new in
                            // Allow only numbers and decimal point.
                            let filtered = new.filter { "0123456789.".contains($0) }
                            if filtered != new {
                                inputText = filtered
                            }
                        }
                }

                Section {
                    Button("Save") {
                        if let qty = Double(inputText), qty > 0 {
                            onSave(qty)
                        }
                    }
                    .disabled(!isValid)

                    Button("Cancel", role: .cancel) {
                        onCancel()
                    }
                }
            }
            .navigationTitle(quantity == nil ? "Add Holding" : "Edit Holding")
        }
    }

    private var isValid: Bool {
        if let qty = Double(inputText), qty > 0 { return true }
        return false
    }
}

//
//  HoldingQuantityView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  HoldingQuantityView.swift
//  CryptoPulse
//

import SwiftUI

struct HoldingQuantityView: View {

    let quantity: Double

    var body: some View {

        VStack(
            alignment: .trailing,
            spacing: 4
        ) {

            Text(quantity.formatted())
                .font(.headline)

            Text("Coins")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {

    HoldingQuantityView(
        quantity: 2.35
    )
}

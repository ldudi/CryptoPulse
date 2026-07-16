//
//  Badge.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  Badge.swift
//

import SwiftUI

struct Badge: View {

    let text: String

    var color: Color = AppColors.accent

    var body: some View {

        Text(text)

            .font(Typography.caption)

            .padding(.horizontal, 8)
            .padding(.vertical, 4)

            .background(
                color.opacity(0.15)
            )

            .foregroundStyle(color)

            .clipShape(Capsule())
    }
}

#Preview {

    HStack {

        Badge(text: "NEW")

        Badge(
            text: "TOP",
            color: .green
        )
    }
}

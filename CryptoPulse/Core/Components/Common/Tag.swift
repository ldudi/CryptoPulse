//
//  Tag.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  Tag.swift
//

import SwiftUI

struct Tag: View {

    let title: String

    var isSelected: Bool = false

    var body: some View {

        Text(title)

            .font(Typography.footnote)

            .padding(.horizontal, Spacing.medium)

            .padding(.vertical, Spacing.xSmall)

            .background(
                isSelected
                ? AppColors.accent
                : AppColors.secondaryBackground
            )

            .foregroundStyle(
                isSelected
                ? Color.white
                : AppColors.primaryText
            )

            .clipShape(
                Capsule()
            )
    }
}

#Preview {

    HStack {

        Tag(title: "All")

        Tag(
            title: "Trending",
            isSelected: true
        )

        Tag(title: "NFT")
    }
}

//
//  CardView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  CardView.swift
//  CryptoPulse
//

import SwiftUI

struct CardView<Content: View>: View {

    @ViewBuilder
    let content: () -> Content

    var body: some View {

        content()

            .padding(AppTheme.horizontalPadding)

            .frame(maxWidth: .infinity)

            .background(
                AppColors.secondaryBackground
            )

            .clipShape(
                RoundedRectangle(
                    cornerRadius: Radius.large
                )
            )

            .appShadow(
                AppShadows.small
            )
    }
}

#Preview {

    CardView {

        Text("Hello CryptoPulse")
    }
    .padding()
}

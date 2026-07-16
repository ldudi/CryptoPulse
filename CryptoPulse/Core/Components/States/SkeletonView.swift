//
//  SkeletonView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  SkeletonView.swift
//  CryptoPulse
//

import SwiftUI

struct SkeletonView: View {

    var width: CGFloat? = nil

    var height: CGFloat = 16

    @State
    private var isAnimating = false

    var body: some View {

        RoundedRectangle(
            cornerRadius: Radius.small
        )
        .fill(
            AppColors.border
        )
        .frame(
            width: width,
            height: height
        )
        .opacity(
            isAnimating ? 0.35 : 0.85
        )
        .animation(
            .easeInOut(duration: 0.9)
            .repeatForever(autoreverses: true),
            value: isAnimating
        )
        .onAppear {

            isAnimating = true
        }
    }
}

#Preview {

    VStack(alignment: .leading, spacing: 12) {

        SkeletonView(width: 220)

        SkeletonView(width: 160)

        SkeletonView(width: 300)

        SkeletonView(height: 140)
    }
    .padding()
}

//
//  SkeletonCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  SkeletonCard.swift
//

import SwiftUI

struct SkeletonCard: View {

    var body: some View {

        CardView {

            VStack(alignment: .leading, spacing: Spacing.medium) {

                SkeletonView(width: 120)

                SkeletonView(width: 180)

                SkeletonView(width: 90)
            }
        }
    }
}

#Preview {

    SkeletonCard()
        .padding()
}

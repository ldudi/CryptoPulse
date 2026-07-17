//
//  CoinStatCard.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
import SwiftUI

struct CoinStatCard: View {

    let title: String

    let value: String

    var body: some View {

        CardView {

            HStack {

                Text(
                    title
                )

                Spacer()

                Text(
                    value
                )
                .fontWeight(
                    .semibold
                )
            }
        }
    }
}

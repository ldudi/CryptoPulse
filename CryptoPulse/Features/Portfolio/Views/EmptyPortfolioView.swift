//
//  EmptyPortfolioView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 18/07/26.
//
//
//import Foundation
//
//  EmptyPortfolioView.swift
//  CryptoPulse
//

import SwiftUI

struct EmptyPortfolioView: View {

    var body: some View {

        ContentUnavailableView {

            Label(
                "No Holdings",
                systemImage: "briefcase"
            )

        } description: {

            Text(
                "Your portfolio is empty. Add coins to start tracking your investments."
            )
        }
    }
}

#Preview {

    EmptyPortfolioView()
}

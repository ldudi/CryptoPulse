//
//  LoadingView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  LoadingView.swift
//  CryptoPulse
//

import SwiftUI

struct LoadingView: View {

    var title: String = "Loading..."

    var body: some View {

        VStack(spacing: Spacing.medium) {

            ProgressView()

            Text(title)
                .font(Typography.body)
                .foregroundStyle(AppColors.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {

    LoadingView()
}

//
//  NavigationBar.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//  AppNavigationBar.swift
//  CryptoPulse
//

import SwiftUI

struct AppNavigationBar<Leading: View, Trailing: View>: View {

    let title: String

    @ViewBuilder
    let leading: () -> Leading

    @ViewBuilder
    let trailing: () -> Trailing

    var body: some View {

        HStack {

            leading()

            Spacer()

            Text(title)
                .font(Typography.title2)

            Spacer()

            trailing()
        }
        .frame(height: 44)
        .padding(.horizontal, AppTheme.horizontalPadding)
    }
}

#Preview {

    AppNavigationBar(
        title: "Markets"
    ) {

        ToolbarButton(
            icon: AppIcon.chevronLeft
        ) {

        }

    } trailing: {

        ToolbarButton(
            icon: AppIcon.search
        ) {

        }
    }
}

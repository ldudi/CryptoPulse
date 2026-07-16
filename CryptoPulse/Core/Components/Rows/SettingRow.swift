//
//  SettingRow.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  SettingRow.swift
//

import SwiftUI

struct SettingRow: View {

    let icon: String

    let title: String

    var value: String?

    var body: some View {

        HStack(spacing: Spacing.medium) {

            Image(systemName: icon)
                .frame(width: 24)

            Text(title)

            Spacer()

            if let value {

                Text(value)
                    .foregroundStyle(AppColors.secondaryText)
            }

            Image(systemName: AppIcon.chevronRight)
                .foregroundStyle(AppColors.secondaryText)
        }
        .padding(.vertical, Spacing.small)
    }
}

#Preview {

    VStack {

        SettingRow(
            icon: AppIcon.settings,
            title: "Appearance",
            value: "System"
        )

        SettingRow(
            icon: AppIcon.chart,
            title: "Charts"
        )
    }
    .padding()
}

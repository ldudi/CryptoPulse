//
//  ToolbarButton.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  ToolbarButton.swift
//

import SwiftUI

struct ToolbarButton: View {

    let icon: String

    var action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            Image(systemName: icon)

                .font(.headline)

                .frame(width: 36, height: 36)

                .background(
                    AppColors.secondaryBackground
                )

                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    ToolbarButton(
        icon: AppIcon.search
    ) {

    }
}

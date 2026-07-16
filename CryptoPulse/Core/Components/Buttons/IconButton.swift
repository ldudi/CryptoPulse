//
//  IconButton.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  IconButton.swift
//  CryptoPulse
//

import SwiftUI

struct IconButton: View {

    let icon: String

    var size: CGFloat = 44

    var action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            Image(systemName: icon)

                .font(.headline)

                .frame(
                    width: size,
                    height: size
                )
                .background(
                    AppColors.secondaryBackground
                )
                .clipShape(
                    Circle()
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    HStack {

        IconButton(
            icon: AppIcon.search
        ) {}

        IconButton(
            icon: AppIcon.plus
        ) {}

        IconButton(
            icon: AppIcon.settings
        ) {}
    }
}

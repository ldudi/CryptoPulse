//
//  NavigationBackButton.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  NavigationBackButton.swift
//

import SwiftUI

struct NavigationBackButton: View {

    @Environment(\.dismiss)
    private var dismiss

    var body: some View {

        ToolbarButton(
            icon: AppIcon.chevronLeft
        ) {

            dismiss()
        }
    }
}

#Preview {

    NavigationBackButton()
}

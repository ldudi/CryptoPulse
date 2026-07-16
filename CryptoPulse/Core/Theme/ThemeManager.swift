//
//  ThemeManager.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  ThemeManager.swift
//

import Observation
import SwiftUI

@Observable
@MainActor
final class ThemeManager {

    enum Theme: String, CaseIterable {

        case system

        case light

        case dark
    }

    var selectedTheme: Theme = .system

    var colorScheme: ColorScheme? {

        switch selectedTheme {

        case .system:
            return nil

        case .light:
            return .light

        case .dark:
            return .dark
        }
    }

    func toggle() {

        switch selectedTheme {

        case .light:

            selectedTheme = .dark

        case .dark:

            selectedTheme = .system

        case .system:

            selectedTheme = .light
        }
    }
}

//
//  SecondaryButton.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  AppButtonStyle.swift
//  CryptoPulse
//

import SwiftUI

enum AppButtonStyle {

    case primary

    case secondary

    case destructive

    case outline

    case plain

    var backgroundColor: Color {

        switch self {

        case .primary:

            return AppColors.accent

        case .secondary:

            return AppColors.secondaryBackground

        case .destructive:

            return AppColors.error

        case .outline:

            return .clear

        case .plain:

            return .clear
        }
    }

    var foregroundColor: Color {

        switch self {

        case .primary:

            return .white

        case .secondary:

            return AppColors.primaryText

        case .destructive:

            return .white

        case .outline:

            return AppColors.accent

        case .plain:

            return AppColors.accent
        }
    }

    var borderColor: Color {

        switch self {

        case .outline:

            return AppColors.border

        default:

            return .clear
        }
    }
}

//
//  Shadows.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  Shadows.swift
//

import SwiftUI

enum AppShadows {

    static let small = Shadow(
        color: .black.opacity(0.08),
        radius: 2,
        x: 0,
        y: 1
    )

    static let medium = Shadow(
        color: .black.opacity(0.12),
        radius: 6,
        x: 0,
        y: 3
    )

    static let large = Shadow(
        color: .black.opacity(0.16),
        radius: 12,
        x: 0,
        y: 6
    )
}

struct Shadow {

    let color: Color

    let radius: CGFloat

    let x: CGFloat

    let y: CGFloat
}

extension View {

    func appShadow(
        _ shadow: Shadow
    ) -> some View {

        self.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}

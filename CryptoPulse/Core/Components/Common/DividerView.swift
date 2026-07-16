//
//  DividerView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  DividerView.swift
//

import SwiftUI

struct DividerView: View {

    var body: some View {

        Divider()
            .overlay(
                AppColors.border
            )
    }
}

#Preview {

    VStack {

        Text("Above")

        DividerView()

        Text("Below")
    }
    .padding()
}

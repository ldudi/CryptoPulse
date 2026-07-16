//
//  SearchBar.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//  SearchBar.swift
//  CryptoPulse
//

import SwiftUI

struct SearchBar: View {

    @Binding
    var text: String

    var placeholder: String = "Search"

    var body: some View {

        HStack(spacing: Spacing.small) {

            Image(systemName: AppIcon.search)
                .foregroundStyle(AppColors.secondaryText)

            TextField(
                placeholder,
                text: $text
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            if !text.isEmpty {

                Button {

                    text = ""

                } label: {

                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppColors.secondaryText)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, Spacing.medium)
        .padding(.vertical, Spacing.small)
        .background(
            AppColors.secondaryBackground
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: Radius.medium
            )
        )
    }
}

#Preview {

    @Previewable
    @State var search = ""

    SearchBar(text: $search)
        .padding()
}

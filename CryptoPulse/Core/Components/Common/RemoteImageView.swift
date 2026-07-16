//
//  AsyncImageView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 16/07/26.
//
//
//import Foundation
//
//  RemoteImageView.swift
//

import SwiftUI

struct RemoteImageView: View {

    let url: URL?

    var body: some View {

        AsyncImage(url: url) { phase in

            switch phase {

            case .empty:

                SkeletonView(width: 40, height: 40)

            case .success(let image):

                image
                    .resizable()
                    .scaledToFit()

            case .failure:

                Image(systemName: AppIcon.bitcoin)
                    .resizable()
                    .scaledToFit()
                    .padding(6)
                    .foregroundStyle(
                        AppColors.secondaryText
                    )

            @unknown default:

                EmptyView()
            }
        }
    }
}

#Preview {

    RemoteImageView(url: nil)
        .frame(width: 60, height: 60)
}

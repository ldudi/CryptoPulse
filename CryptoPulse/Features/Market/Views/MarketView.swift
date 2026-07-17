//
//  MarketView.swift
//  CryptoPulse
//
//  Created by Labhesh Dudi on 17/07/26.
//
//
//import Foundation
//
//
//  MarketView.swift
//  CryptoPulse
//

import SwiftUI

struct MarketView: View {
    @Environment(DIContainer.self)
    private var container
    
    @State
    private var viewModel: MarketViewModel?
    
    var body: some View {
        
        Group {
            
            if let viewModel {
                
                MarketContentView(viewModel: viewModel)
                
            } else {
                
                LoadingView()
            }
        }
        .task {
            
            guard viewModel == nil else { return }
            
            let vm = container.features.makeMarketViewModel()
            
            viewModel = vm
            
            await vm.loadMarkets()
        }
    }
}

import Foundation

enum PortfolioViewState {
    case idle
    case loading
    case empty
    case loaded([PortfolioAsset])
    case failed(Error)
}

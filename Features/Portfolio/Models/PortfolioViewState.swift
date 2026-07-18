import Foundation

enum PortfolioViewState {
    case idle
    case loading
    case empty
    case loaded([PortfolioHolding])
    case failed(Error)
}

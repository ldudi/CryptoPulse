import Foundation
import Observation
import CryptoPulseDomain

@MainActor
@Observable
final class CoinDetailViewModel {
    
    let chartViewModel: ChartViewModel
    
    // MARK: - State
    
    private(set) var state: CoinDetailViewState = .idle
    
    // MARK: - Holding State
    
    /// Current holding for the displayed coin, if any.
    private(set) var currentHolding: PortfolioHolding?
    
    /// Indicates whether a save or delete operation is in progress.
    var isSaving: Bool = false
    
    /// Indicates whether the holding editor sheet should be shown.
    var isShowingEditor: Bool = false
    
    // MARK: - Dependencies
    
    private let coinID: String
    private let getCoinDetail: GetCoinDetailUseCase
    private let addHoldingUseCase: AddHoldingUseCase
    private let updateHoldingUseCase: UpdateHoldingUseCase
    private let deleteHoldingUseCase: DeleteHoldingUseCase
    private let getHoldingUseCase: GetHoldingUseCase
    private let getChartDataUseCase: GetChartDataUseCase
    
    // MARK: - Init
    
    init(
        coinID: String,
        getChartDataUseCase: GetChartDataUseCase,
        getCoinDetail: GetCoinDetailUseCase,
        addHoldingUseCase: AddHoldingUseCase,
        updateHoldingUseCase: UpdateHoldingUseCase,
        deleteHoldingUseCase: DeleteHoldingUseCase,
        getHoldingUseCase: GetHoldingUseCase
    ) {
        self.chartViewModel = ChartViewModel(
            coinId: coinID,
            getChartDataUseCase: getChartDataUseCase
        )
        
        self.coinID = coinID
        self.getCoinDetail = getCoinDetail
        self.addHoldingUseCase = addHoldingUseCase
        self.updateHoldingUseCase = updateHoldingUseCase
        self.deleteHoldingUseCase = deleteHoldingUseCase
        self.getHoldingUseCase = getHoldingUseCase
        self.getChartDataUseCase = getChartDataUseCase
    }
    
    // MARK: - Derived Properties
    
    var coin: CoinDetail? {
        guard case let .loaded(coin) = state else { return nil }
        return coin
    }
    
    var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    // MARK: - Actions
    
    func loadCoin() async {
        guard case .idle = state else { return }
        await fetchCoin()
    }
    
    func refresh() async {
        await fetchCoin()
    }
    
    /// Show the holding editor sheet.
    func showEditor() {
        isShowingEditor = true
    }
    
    /// Hide the holding editor sheet.
    func hideEditor() {
        isShowingEditor = false
    }
    
    /// Save or update a holding with the given quantity.
    func saveHolding(quantity: Double) async {
        isSaving = true
        defer { isSaving = false }
    
        do {
            if let existing = currentHolding {
                // Update existing holding
                let updated = PortfolioHolding(
                    coinID: existing.coinID,
                    symbol: existing.symbol,
                    name: existing.name,
                    imageURL: existing.imageURL,
                    quantity: quantity,
                    averageBuyPrice: existing.averageBuyPrice
                )
                try await updateHoldingUseCase.execute(updated)
            } else {
                guard let coin = self.coin else { return }
                // Add new holding
                let newHolding = PortfolioHolding(
                    coinID: coin.id,
                    symbol: coin.symbol,
                    name: coin.name,
                    imageURL: coin.imageURL,
                    quantity: quantity,
                    averageBuyPrice: 0.0 // Default value, will be updated when user enters it
                )
                try await addHoldingUseCase.execute(newHolding)
            }
    
            // Reload holding after successful operation.
            await loadHolding()
            hideEditor()
        } catch {
            // In a production app you would surface this error to the UI.
            print("Error saving holding: \(error)")
        }
    }
    
    /// Delete the current holding.
    func deleteHolding() async {
        isSaving = true
        defer { isSaving = false }
    
        do {
            try await deleteHoldingUseCase.execute(coinID: coinID)
            currentHolding = nil
            hideEditor()
        } catch {
            print("Error deleting holding: \(error)")
        }
    }
    
    // MARK: - Private
    
    private func fetchCoin() async {
        state = .loading
    
        do {
            let coin = try await getCoinDetail(id: coinID)
            state = .loaded(coin)
    
            // Load the holding after the coin has been fetched.
            await loadHolding()
        } catch {
            state = .failed(error)
        }
    }
    
    /// Loads the current holding for this coin, if it exists.
    private func loadHolding() async {
        do {
            let holding = try await getHoldingUseCase.execute(coinID: coinID)
            currentHolding = holding
        } catch {
            // If loading fails we simply keep `currentHolding` nil.
            print("Error loading holding: \(error)")
        }
    }
}

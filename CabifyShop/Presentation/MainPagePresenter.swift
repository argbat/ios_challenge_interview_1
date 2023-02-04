//
//  MainPagePresenter.swift
//  CabifyShop
//
//  Created by Demian Odasso on 01/02/2023.
//

import Combine

/// Present data to the main app view.
class MainPagePresenter: ObservableObject {
    @Published var mainPage = MainPagePresentable(cartBadgeValue: 0)

    private let cartCounterObserveUseCase: CartCounterObserveUseCase
    private var cancelables: Set<AnyCancellable> = []
    
    init(cartCounterObserveUseCase: CartCounterObserveUseCase) {
        self.cartCounterObserveUseCase = cartCounterObserveUseCase
    }
    
    func observeUpdates() {
        cartCounterObserveUseCase.execute().sink { [weak self] counter in
            guard let self = self else { return }
            self.mainPage = self.mainPage.copyWith(cartBadgeValue: Int(counter))
        }.store(in: &cancelables)
    }
}

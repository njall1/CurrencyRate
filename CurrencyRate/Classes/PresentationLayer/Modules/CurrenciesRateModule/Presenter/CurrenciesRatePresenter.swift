//
//  CurrenciesRatePresenter.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrenciesRatePresenter {
    private weak var view: CurrenciesRateViewInput!
    private var rateService: RateServiceInput
    private var pairsStorage: PairsStorageServiceInput
    
    var finishFlow: EmptyCallback?
    
    private lazy var fetchPairsRequestAction = DeferredAction(deferTime: Constants.pairsToUpdateTime) { [weak self] in
        self?.updatePairs()
    }
    
    init(view: CurrenciesRateViewInput, rateService: RateServiceInput, pairsStorage: PairsStorageServiceInput) {
        self.view = view
        self.rateService = rateService
        self.pairsStorage = pairsStorage
    }
}

extension CurrenciesRatePresenter: CurrenciesRateModuleInput {
    func toPresent() -> UIViewController? {
        return view as? UIViewController
    }
}

extension CurrenciesRatePresenter: PairAdapterDelegate {
    func shouldDeleteRow(at row: Int) {
        var pairs = self.pairsStorage.pairs
        pairs.remove(at: row)
        self.pairsStorage.pairs = pairs
        
        self.updateEmptyView()
    }
}

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {
    func userDidClickEditMode(_ isEditing: Bool) {
        if isEditing {
            self.fetchPairsRequestAction.cancel()
        } else {
            self.fetchPairsRequestAction.run()
        }
    }
    
    func viewDidLoad() {
        self.view.hideRepeatView()
        self.updateEmptyView()
        
        if !self.pairsStorage.pairs.isEmpty {
            self.view.isLoading = true
            self.fetchPairsRequestAction.run()
        }
    }
    
    func viewDidDisappear() {
        self.fetchPairsRequestAction.cancel()
    }
    
    func userDidClickAddPair() {
        self.finishFlow?()
    }
    
    func userDidClickRepeat() {
        self.fetchPairsRequestAction.run()
    }
}

private extension CurrenciesRatePresenter {
    func updateEmptyView() {
        if self.pairsStorage.pairs.isEmpty {
            self.view.showEmptyView()
        } else {
            self.view.hideEmptyView()
        }
    }
    
    func updatePairs() {
        self.rateService.fetchRates(pairs: self.pairsStorage.pairs) { [weak self] result in
            guard let self = self else { return }

            self.view.isLoading = false
            switch result {
            case .failure:
                self.view.showRepeatView()
                self.fetchPairsRequestAction.cancel()
            case .success(let list):
                self.view.hideRepeatView()
                self.fetchPairsRequestAction.defer()
                self.view.showPairs(list.map { PairTableViewCell.DisplayItem(leftTitle: "1" + " " + $0.pair.first.code,
                                                                             leftSubtitle: $0.pair.first.name,
                                                                             rightTitle: $0.value.makeRateAttributedString(),
                                                                             rightSubtitle: $0.pair.second.name + " • " + $0.pair.second.code) })
            }
        }
    }
}

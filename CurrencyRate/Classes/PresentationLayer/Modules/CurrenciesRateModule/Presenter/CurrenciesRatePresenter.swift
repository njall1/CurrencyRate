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
    private var storage: [Pair]
    private var pairService: PairsServiceInput
    
    var finishFlow: EmptyCallback?
    
    private lazy var fetchPairsRequestAction = DeferredAction(deferTime: Constants.pairsToUpdateTime) { [weak self] in
        self?.updatePairs()
    }
    
    init(view: CurrenciesRateViewInput, pairs: [Pair], pairService: PairsServiceInput) {
        self.view = view
        self.storage = pairs
        self.pairService = pairService
    }
}

extension CurrenciesRatePresenter: CurrenciesRateModuleInput {
    func toPresent() -> UIViewController? {
        return view as? UIViewController
    }
}

extension CurrenciesRatePresenter: PairAdapterDelegate {
    func shouldDeleteRow(at row: Int) {
        self.storage.remove(at: row)
    }
}

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {
    func userDidClickEditMode(_ isEditing: Bool) {
        if isEditing {
            self.fetchPairsRequestAction.cancel()
        } else {
            self.fetchPairsRequestAction.defer()
        }
    }
    
    func viewDidLoad() {
        self.fetchPairsRequestAction.run()
    }
    
    func viewDidDisappear() {
        self.fetchPairsRequestAction.cancel()
    }
    
    func userDidClickAddPair() {
        self.finishFlow?()
    }
}

private extension CurrenciesRatePresenter {
    func updatePairs() {
        self.pairService.fetchPairs(pairs: self.storage) { [weak self] result in
            guard let self = self else { return }
            
            self.fetchPairsRequestAction.defer()
            
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let list):
                self.view.showPairs(list.map { PairTableViewCell.DisplayItem(leftTitle: "1" + " " + $0.pair.first.code,
                                                                             leftSubtitle: $0.pair.first.name,
                                                                             rightTitle: $0.value.makeRateAttributedString(),
                                                                             rightSubtitle: $0.pair.secodn.name + " " + $0.pair.secodn.code) })
            }
        }
    }
}

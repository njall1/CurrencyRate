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

extension CurrenciesRatePresenter: CurrenciesRateViewOutput {
    func viewDidLoad() {
        self.pairService.fetchPairs(pairs: self.storage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let list):
                self.view.showPairs(list.map { PairTableViewCell.DisplayItem(leftTitle: "1" + " " + $0.pair.0.code,
                                                                              leftSubtitle: $0.pair.0.name,
                                                                              rightTitle: $0.value.makeRateAttributedString(),
                                                                              rightSubtitle: $0.pair.1.name + " " + $0.pair.1.code) })
            }
        }
    }
    
    func userDidClickAddPair() {
        self.finishFlow?()
    }
}

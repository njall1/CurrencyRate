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
                                                                              rightTitle: self.makeAttributetString(rate: $0.value),
                                                                              rightSubtitle: $0.pair.1.name + " " + $0.pair.1.code) })
            }
        }
    }
    
    func userDidClickAddPair() {
        self.finishFlow?()
    }
}

private extension CurrenciesRatePresenter {
    func makeAttributetString(rate: Double) -> NSAttributedString {
        let string = "\(rate)"
        var substring = string.components(separatedBy: ".")[1]
        
        substring = String(substring.dropFirst(2))
        
        var attributedString = NSMutableAttributedString()
        if let rangeSubstring = string.nsRange(of: substring) {
            attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], range: rangeSubstring)
        }
        
        return attributedString as NSAttributedString
    }
}

extension StringProtocol {
    func nsRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
    
    func nsRange(of substring: String) -> NSRange? {
        var range: NSRange?
        if let rangeSubsting = self.range(of: substring) {
            range = self.nsRange(from: rangeSubsting)
        }
        
        return range
    }
}

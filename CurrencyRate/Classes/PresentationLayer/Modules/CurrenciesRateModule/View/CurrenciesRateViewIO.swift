//
//  CurrenciesRateViewIO.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import Foundation

protocol CurrenciesRateViewInput: AnyObject {
    var isLoading: Bool { get set }
    func showPairs(_ list: [PairTableViewCell.DisplayItem])
    func showEmptyView()
    func hideEmptyView()
    func showRepeatView() 
    func hideRepeatView()
}

protocol CurrenciesRateViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
    func userDidClickAddPair()
    func userDidClickEditMode(_ isEditing: Bool)
    func userDidClickRepeat()
}

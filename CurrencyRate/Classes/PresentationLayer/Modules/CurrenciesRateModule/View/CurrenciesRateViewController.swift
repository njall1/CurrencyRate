//
//  CurrenciesRateViewController.swift
//  CurrencyRate
//
//  Created by v.rusinov on 22/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

class CurrenciesRateViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var output: CurrenciesRateViewOutput!
    var adapter: PairAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter.tableView = self.tableView
        self.output.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.output.viewDidDisappear()
    }
}

extension CurrenciesRateViewController: CurrenciesRateViewInput {
    func showPairs(_ list: [PairTableViewCell.DisplayItem]) {
        self.adapter.reloadData(dataSource: list)
    }
}

// MARK: - Actions

extension CurrenciesRateViewController {
    @IBAction private func didClickPlusButton(_ sender: UIButton) {
        self.output.userDidClickAddPair()
    }
}

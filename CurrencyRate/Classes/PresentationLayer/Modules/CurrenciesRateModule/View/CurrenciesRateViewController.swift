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
        self.adapter.delegate = output as? PairAdapterDelegate
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
    
    @IBAction private func didClickEditButton(_ sender: UIButton) {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        self.adapter.isEditingMode = self.tableView.isEditing
        self.output.userDidClickEditMode(self.tableView.isEditing)
    }
}

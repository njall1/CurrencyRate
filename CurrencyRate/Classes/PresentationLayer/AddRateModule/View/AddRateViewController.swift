//
//  AddRateViewController.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class AddRateViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    private var output: AddRateViewOutput!
    private var adapter: AddRateAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.injectDependencies()
        self.output.viewDidLoad()
    }
}

private extension AddRateViewController {
    func injectDependencies() {
        self.output = AddRatePresenter(view: self, currenciesService: CurrenciesService())
        self.adapter = AddRateAdapter()
        self.adapter.tableView = self.tableView
        self.adapter.delegate = self.output as? AddRateAdapterDelegate
    }
}

extension AddRateViewController: AddRateViewInput {
    func showCurrencies(_ list: [AddRateTableViewCell.DisplayItem]) {
        self.adapter.reloadData(dataSource: list)
    }
}

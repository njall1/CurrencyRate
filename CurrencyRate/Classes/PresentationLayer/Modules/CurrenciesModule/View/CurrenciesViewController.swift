//
//  CurrenciesViewController.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrenciesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    var output: CurrenciesViewOutput!
    var adapter: CurrenciesAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter.tableView = self.tableView
        self.output.viewDidLoad()
    }
}

extension CurrenciesViewController: CurrenciesViewInput {
    func showCurrencies(_ list: [CurrencyTableViewCell.DisplayItem]) {
        self.adapter.reloadData(dataSource: list)
    }
}

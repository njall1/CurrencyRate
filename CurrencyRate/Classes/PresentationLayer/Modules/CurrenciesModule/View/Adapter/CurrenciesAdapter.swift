//
//  AddRateAdapter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

protocol CurrenciesAdapterDelegate: AnyObject {
    func didSelectRowAt(index: Int)
}

final class CurrenciesAdapter: NSObject {
    weak var delegate: CurrenciesAdapterDelegate?
    private var dataSource = [CurrencyTableViewCell.DisplayItem]()
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.register(UINib(nibName: CurrencyTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.identifier)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.reloadData()
        }
    }
    
    func reloadData(dataSource: [CurrencyTableViewCell.DisplayItem]) {
        self.dataSource = dataSource
        self.tableView?.reloadData()
    }
}

extension CurrenciesAdapter: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.didSelectRowAt(index: indexPath.row)
    }
}

extension CurrenciesAdapter: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int
    {
        return self.dataSource.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath)
        let displayItem = self.dataSource[indexPath.row]
        (cell as? CurrencyTableViewCell)?.configure(displayItem: displayItem)
        return cell
    }
}

//
//  AddRateAdapter.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

protocol AddRateAdapterDelegate: AnyObject {
    func didDeselectRowAt(index: Int)
}

final class AddRateAdapter: NSObject {
    weak var delegate: AddRateAdapterDelegate?
    private var dataSource = [AddRateTableViewCell.DisplayItem]()
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.register(UINib(nibName: AddRateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AddRateTableViewCell.identifier)
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.reloadData()
        }
    }
    
    func reloadData(dataSource: [AddRateTableViewCell.DisplayItem]) {
        self.dataSource = dataSource
        self.tableView?.reloadData()
    }
}

extension AddRateAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.delegate?.didDeselectRowAt(index: indexPath.row)
    }
}

extension AddRateAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddRateTableViewCell.identifier, for: indexPath)
        let displayItem = self.dataSource[indexPath.row]
        (cell as? AddRateTableViewCell)?.configure(displayItem: displayItem)
        return cell
    }
}

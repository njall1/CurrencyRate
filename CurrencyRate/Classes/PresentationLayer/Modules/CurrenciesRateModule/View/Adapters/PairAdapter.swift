//
//  PairAdapter.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

protocol PairAdapterDelegate: AnyObject {
    func shouldDeleteRow(at row: Int)
}

final class PairAdapter: NSObject {
    weak var delegate: PairAdapterDelegate?
    private var dataSource = [PairTableViewCell.DisplayItem]()
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.register(UINib(nibName: PairTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PairTableViewCell.identifier)
            self.tableView?.allowsSelection = false
            self.tableView?.dataSource = self
            self.tableView?.reloadData()
        }
    }
    
    var isEditingMode: Bool = false {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    func reloadData(dataSource: [PairTableViewCell.DisplayItem]) {
        self.dataSource = dataSource
        self.tableView?.reloadData()
    }
}

extension PairAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PairTableViewCell.identifier, for: indexPath)
        let displayItem = self.dataSource[indexPath.row]
        (cell as? PairTableViewCell)?.configure(displayItem: displayItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.isEditingMode
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.delegate?.shouldDeleteRow(at: indexPath.row)
            self.dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert, .none:
            break
        @unknown default:
            fatalError("UITableView commit editingStyle issue!")
        }
    }
}


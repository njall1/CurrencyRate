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
    @IBOutlet private var emptyView: UIView!
    
    @IBOutlet private var mainView: UIView!
    @IBOutlet private var repeatView: UIView!
    
    @IBOutlet private var plusButton: UIButton!
    @IBOutlet private var loaderView: UIActivityIndicatorView!
    
    var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                self.plusButton.isEnabled = false
                self.loaderView.startAnimating()
            } else {
                self.plusButton.isEnabled = true
                self.loaderView.stopAnimating()
            }
        }
    }
    
    var output: CurrenciesRateViewOutput!
    var adapter: PairAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.hidesWhenStopped = true
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
    
    func showEmptyView() {
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
    }
    
    func hideEmptyView() {
        self.tableView.isHidden = false
        self.emptyView.isHidden = true
    }
    
    func showRepeatView() {
        self.repeatView.isHidden = false
        self.mainView.isHidden = true
    }
    
    func hideRepeatView() {
        self.repeatView.isHidden = true
        self.mainView.isHidden = false
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
    
    @IBAction private func didClickRepeatButton(_ sender: UIButton) {
        self.output.userDidClickRepeat()
    }
}

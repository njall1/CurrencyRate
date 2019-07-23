//
//  EmptyCurrenciesRateViewController.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 21/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

class EmptyCurrenciesRateViewController: UIViewController {
    var output: EmptyCurrenciesRateViewOutput!
}

private extension EmptyCurrenciesRateViewController {
    @IBAction func didClickAddCurrencyPair(_ sender: UIButton) {
        self.output.userDidClickAddCurrencyPair()
    }
}

extension EmptyCurrenciesRateViewController: EmptyCurrenciesRateViewInput { }

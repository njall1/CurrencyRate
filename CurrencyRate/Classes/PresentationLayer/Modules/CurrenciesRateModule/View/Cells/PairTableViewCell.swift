//
//  PairTableViewCell.swift
//  CurrencyRate
//
//  Created by v.rusinov on 23/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

class PairTableViewCell: UITableViewCell {
    struct DisplayItem {
        let leftTitle: String
        let leftSubtitle: String
        let rightTitle: String
        let rightSubtitle: String
    }
    
    @IBOutlet private var leftTitleLabel: UILabel!
    @IBOutlet private var rightTitleLabel: UILabel!
    @IBOutlet private var leftSubtitleLabel: UILabel!
    @IBOutlet private var rightSubtitleLabel: UILabel!
    
    static let identifier: String = "PairTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leftTitleLabel.text = nil
        self.rightTitleLabel.text = nil
        self.leftSubtitleLabel.text = nil
        self.rightSubtitleLabel.text = nil
    }
    
    func configure(displayItem: DisplayItem) {
        self.leftTitleLabel.text = displayItem.leftTitle
        self.rightTitleLabel.text = displayItem.rightTitle
        self.leftSubtitleLabel.text = displayItem.leftSubtitle
        self.rightSubtitleLabel.text = displayItem.rightSubtitle
    }
}

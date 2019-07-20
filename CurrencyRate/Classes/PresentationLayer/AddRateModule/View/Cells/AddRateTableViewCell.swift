//
//  AddRateTableViewCell.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class AddRateTableViewCell: UITableViewCell {
    struct DisplayItem {
        let thumbnailIName: String
        let title: String
        let subtitle: String
    }
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    static let identifier: String = "AddRateTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(displayItem: DisplayItem) {
        self.titleLabel.text = displayItem.title
        self.subtitleLabel.text = displayItem.subtitle
        self.thumbnailImageView.image = UIImage(named: displayItem.thumbnailIName)
    }
}

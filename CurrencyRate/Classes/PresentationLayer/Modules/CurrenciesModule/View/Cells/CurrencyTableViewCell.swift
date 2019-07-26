//
//  AddRateTableViewCell.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 20/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    struct DisplayItem {
        let thumbnailName: String
        let thumbnailAlpha: CGFloat
        let title: String
        let titleAlpha: CGFloat
        let subtitle: String
        let subtitleAlpha: CGFloat
    }
    
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    static let identifier: String = "CurrencyTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.thumbnailImageView.image = nil
    }
    
    func configure(displayItem: DisplayItem) {
        self.titleLabel.text = displayItem.title
        self.titleLabel.alpha = displayItem.titleAlpha
        self.subtitleLabel.text = displayItem.subtitle
        self.subtitleLabel.alpha = displayItem.subtitleAlpha
        
        if let image = UIImage(named: displayItem.thumbnailName) {
            self.thumbnailImageView.image = image
        } else {
            self.thumbnailImageView.image = UIImage(named: "DEFAULT")
        }
        
        self.thumbnailImageView.alpha = displayItem.thumbnailAlpha
    }
}

//
//  Extensions.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

// MARK: - Double

extension Double {
    func makeRateAttributedString() -> NSAttributedString {
        let string = String(self)
        let selectDecimalPartSince = 2
        let components = string.components(separatedBy: ".")
        let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: Constants.mainFont])
        
        guard let integerPartCount = components.item(at: 0)?.count,
            let decimalPartCount = components.item(at: 1)?.count
            else { return NSAttributedString(string: string) }
        
        let mainPartCount = integerPartCount + 1
        
        if decimalPartCount > selectDecimalPartSince {
            let from = mainPartCount + selectDecimalPartSince
            let nsRange = NSRange(location: from, length: decimalPartCount - selectDecimalPartSince)
            attributedString.addAttributes([NSAttributedString.Key.font: Constants.additionalFont], range: nsRange)
        }
        
        return attributedString as NSAttributedString
    }
}

// MARK: - Array

extension Array {
    
    func item(at index: Int) -> Element? {
        guard 0..<count ~= index else { return nil }
        return self[index]
    }
    
}

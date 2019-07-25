//
//  Extensions.swift
//  CurrencyRate
//
//  Created by Vitaliy Rusinov on 25/07/2019.
//  Copyright © 2019 Vitaliy Rusinov. All rights reserved.
//

import UIKit

// MARK: - StringProtocol

extension StringProtocol {
    func nsRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
    
    func nsRange(of substring: String) -> NSRange? {
        var range: NSRange?
        if let rangeSubsting = self.range(of: substring) {
            range = self.nsRange(from: rangeSubsting)
        }
        
        return range
    }
}

// MARK: - Doube

extension Double {
    func makeRateAttributedString() -> NSAttributedString {
        let string = String(self)
        let substring = String(string.components(separatedBy: ".")[1].dropFirst(2))
        
        var attributedString = NSMutableAttributedString()
        if let rangeSubstring = string.nsRange(of: substring) {
            attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], range: rangeSubstring)
        }
        
        return attributedString as NSAttributedString
    }
}

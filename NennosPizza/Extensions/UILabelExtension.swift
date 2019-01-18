//
//  UILabelExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/12/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UILabel {
    @discardableResult func applyTextSpacing(text: String, value: Double) -> NSAttributedString? {
        self.attributedText = NSAttributedString(string: text, attributes: [.kern: value])
        return self.attributedText
    }

    @discardableResult func applyTextSpacing(value: Double) -> NSAttributedString? {
        return self.applyTextSpacing(text: self.text ?? "", value: value)
    }
}

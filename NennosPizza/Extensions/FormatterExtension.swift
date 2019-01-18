//
//  FormatterExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

extension Formatter {
    static let formatterAmount: NumberFormatter = {
        let numberFormetter = NumberFormatter()
        numberFormetter.locale = Locale.usa
        numberFormetter.numberStyle = .currency
        numberFormetter.maximumFractionDigits = 2
        numberFormetter.minimumFractionDigits = 0
        return numberFormetter
    }()
}

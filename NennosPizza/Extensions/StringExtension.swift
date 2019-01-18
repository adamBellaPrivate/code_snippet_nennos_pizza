//
//  StringExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

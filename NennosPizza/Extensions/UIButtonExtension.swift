//
//  UIButtonExtension.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

extension UIButton {
    func applyRedStyle() {
        backgroundColor = AppTheme.redBtnBackground
        setTitleColor(AppTheme.secondaryText, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
    }

    func applyYellowStyle() {
        backgroundColor = AppTheme.yellowBtnBackground
        setTitleColor(AppTheme.secondaryText, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
    }

    func applyEnableStyle(by enabled: Bool) {
        alpha = !enabled ? 0.5 : 1
        isEnabled = enabled
    }
}

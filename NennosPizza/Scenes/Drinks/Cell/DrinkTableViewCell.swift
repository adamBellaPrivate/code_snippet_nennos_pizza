//
//  DrinkTableViewCell.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblDrinkName: UILabel! {
        didSet {
            lblDrinkName.textColor = AppTheme.primaryText
            lblDrinkName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    @IBOutlet private weak var lblDrinkPrice: UILabel! {
        didSet {
            lblDrinkPrice.textColor = AppTheme.primaryText
            lblDrinkPrice.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }

    final func setupCell(by drink: Drink) {
        lblDrinkName.text = drink.name
        lblDrinkPrice.text = Formatter.formatterAmount.string(from: NSNumber(value: drink.price))

        lblDrinkName.applyTextSpacing(value: -0.41)
        lblDrinkPrice.applyTextSpacing(value: -0.41)
    }
}

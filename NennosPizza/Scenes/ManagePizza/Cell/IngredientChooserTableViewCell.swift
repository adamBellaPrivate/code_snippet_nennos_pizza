//
//  IngredientChooserTableViewCell.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

class IngredientChooserTableViewCell: UITableViewCell {

    @IBOutlet private weak var imgCheckMark: UIImageView!
    @IBOutlet private weak var lblIngredientName: UILabel! {
        didSet {
            lblIngredientName.textColor = AppTheme.primaryText
            lblIngredientName.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
    }
    @IBOutlet private weak var lblPrice: UILabel! {
        didSet {
            lblPrice.textColor = AppTheme.primaryText
            lblPrice.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        }
    }

    final func setupCell(by ingredient: Ingredient, isSelected: Bool = false) {
        lblIngredientName.text = ingredient.name
        lblPrice.text = Formatter.formatterAmount.string(from: NSNumber(value: ingredient.price))
        imgCheckMark.alpha = isSelected ? 1 : 0
        lblIngredientName.applyTextSpacing(value: -0.41)
        lblPrice.applyTextSpacing(value: -0.41)
    }
}

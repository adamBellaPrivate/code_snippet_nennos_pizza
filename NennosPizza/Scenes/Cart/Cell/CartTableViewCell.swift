//
//  CartTableViewCell.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift

typealias DidRemoveProductCallback = (_ product: Product) -> Void

class CartTableViewCell: UITableViewCell {

    @IBOutlet private weak var lblItemPrice: UILabel! {
        didSet {
            lblItemPrice.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            lblItemPrice.textColor = AppTheme.primaryText
        }
    }
    @IBOutlet private weak var lblItemName: UILabel! {
        didSet {
            lblItemName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            lblItemName.textColor = AppTheme.primaryText
        }
    }
    @IBOutlet private weak var btnDelete: UIButton!

    private var handler: DidRemoveProductCallback?
    private var product: Product?

    final func setupCell(by product: Product, onComplition handler: DidRemoveProductCallback? = .none) {
        self.product = product
        self.handler = handler
        if let pizza = product as? CompletePizza, !pizza.originalIngredientIds.isEmpty, !pizza.originalIngredientIds.elementsEqual(pizza.ingredients.compactMap({ $0.id })) {
            lblItemName.text = "\("screen.cart.custom_pizza.prefix".localized) \(product.name)"
        } else {
            lblItemName.text = product.name
        }
        lblItemPrice.text = Formatter.formatterAmount.string(from: NSNumber(value: product.price))

        lblItemName.applyTextSpacing(value: -0.41)
        lblItemPrice.applyTextSpacing(value: -0.41)
    }

    @IBAction final func actionDeleteItem(_ sender: Any) {
        guard let wProduct = product else { return }
        handler?(wProduct)
    }
}

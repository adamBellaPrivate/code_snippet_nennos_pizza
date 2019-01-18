//
//  PizzaTableViewCell.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import Kingfisher

typealias DidAddToCartCallback = (_ pizza: CompletePizza) -> Void

class PizzaTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 178

    @IBOutlet private weak var lblPizzaName: UILabel! {
        didSet {
            lblPizzaName.textColor = AppTheme.primaryText
            lblPizzaName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
    }
    @IBOutlet private weak var lblPizzaIngredientsName: UILabel! {
        didSet {
            lblPizzaIngredientsName.textColor = AppTheme.primaryText
            lblPizzaIngredientsName.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    @IBOutlet weak var imgPizzaImageView: UIImageView!
    @IBOutlet private weak var btnAddToCart: UIButton! {
        didSet {
            btnAddToCart.applyYellowStyle()
            btnAddToCart.layer.cornerRadius = 4
        }
    }

    private var pizza: CompletePizza?
    private var handler: DidAddToCartCallback?

    final func setupCell(by pizza: CompletePizza, onComplition handler: DidAddToCartCallback? = .none) {
        self.handler = handler
        self.pizza = pizza
        lblPizzaName.text = pizza.name
        lblPizzaIngredientsName.text = pizza.ingredientNames
        imgPizzaImageView.image = .none
        btnAddToCart.setTitle(Formatter.formatterAmount.string(from: NSNumber(value: pizza.price)), for: .normal)
        btnAddToCart.titleLabel?.applyTextSpacing(value: -0.39)
        if let imageURLString = pizza.imageUrl {
            imgPizzaImageView.kf.indicatorType = .activity
            let processor = ResizingImageProcessor(referenceSize: imgPizzaImageView.bounds.size, mode: .aspectFill)
            imgPizzaImageView.kf.setImage(with: URL(string: imageURLString), options: [.processor(processor),
                                                                                       .transition(.fade(0.2))])
        }

        lblPizzaName.applyTextSpacing(value: -0.58)
        lblPizzaIngredientsName.applyTextSpacing(value: -0.34)
    }

    @IBAction func actionAddToCart(_ sender: Any) {
        guard let wPizza = pizza else { return }
        handler?(wPizza)
    }
}

//
//  ManagePizzaHeaderView.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import Kingfisher

class ManagePizzaHeaderView: UIView {
    private static let customHeaderHeight: CGFloat = 365

    @IBOutlet private weak var imgPizza: UIImageView!
    @IBOutlet weak var lblIngredientsDesc: UILabel! {
        didSet {
            lblIngredientsDesc.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
            lblIngredientsDesc.text = "screen.manage_pizza.header.ingredients.desc".localized
            lblIngredientsDesc.textColor = AppTheme.primaryText
            lblIngredientsDesc.applyTextSpacing(value: -0.58)
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: UIApplication.fixedTopSafeAreInset(), width: UIScreen.main.bounds.width, height: ManagePizzaHeaderView.customHeaderHeight))
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }

    final func configureHeaderView(by imageURLPath: String?, isCustomPizza: Bool = false) {
        guard !isCustomPizza else {
            imgPizza.image = #imageLiteral(resourceName: "ic_empty_pizza")
            return
        }
        imgPizza.image = .none
        if let imageURLString = imageURLPath {
            imgPizza.kf.indicatorType = .activity
            let processor = ResizingImageProcessor(referenceSize: imgPizza.bounds.size, mode: .aspectFill)
            imgPizza.kf.setImage(with: URL(string: imageURLString), options: [.processor(processor), .transition(.fade(0.2))])

        }
    }
}

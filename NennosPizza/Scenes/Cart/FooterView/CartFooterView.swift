//
//  CartFooterView.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

class CartFooterView: UIView {
    private static let customFooterHeight: CGFloat = 118

    @IBOutlet private weak var lblAmountDesc: UILabel! {
        didSet {
            lblAmountDesc.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            lblAmountDesc.text = "screen.cart.total_amount_desc".localized.uppercased()
            lblAmountDesc.textColor = AppTheme.primaryText
            lblAmountDesc.applyTextSpacing(value: -0.41)
        }
    }
    @IBOutlet private weak var lblAmountValue: UILabel! {
        didSet {
            lblAmountValue.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            lblAmountValue.textColor = AppTheme.primaryText
        }
    }

    init() {
        super.init(frame: CGRect(x: 0, y: UIApplication.fixedTopSafeAreInset(), width: UIScreen.main.bounds.width, height: CartFooterView.customFooterHeight))
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }

    final func configureFooter(_ totalAmount: Double) {
        lblAmountValue.text = Formatter.formatterAmount.string(from: NSNumber(value: totalAmount))
        lblAmountValue.applyTextSpacing(value: -0.41)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

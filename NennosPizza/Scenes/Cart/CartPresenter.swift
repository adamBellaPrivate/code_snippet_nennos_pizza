//
//  CartPresenter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol CartPresentationLogic: class {
    func manageCartContent(_ products: [Product])
    func managePurchaseSuccessResult()
}

class CartPresenter {
    private weak var view: CartDisplayLogic?

    init(_ resourceView: CartDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension CartPresenter: CartPresentationLogic {
    final func manageCartContent(_ products: [Product]) {
        view?.showCartContent(products)
    }

    final func managePurchaseSuccessResult() {
        view?.showPurchaseSuccessResult()
    }
}

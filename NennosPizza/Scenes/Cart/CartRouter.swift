//
//  CartRouter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

protocol CartRoutingLogic {
    func navigateToDrinks()
    func navigateToSuccessFinish()
}

class CartRouter {
    private weak var viewController: CartViewController?

    init(resource: CartViewController) {
        viewController = resource
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension CartRouter: CartRoutingLogic {
    final func navigateToDrinks() {
        viewController?.navigationController?.pushViewController(DrinksViewController(), animated: true)
    }

    final func navigateToSuccessFinish() {
        viewController?.present(FinishViewController(), animated: true, completion: { [weak self] in
            guard let wSelf = self else { return }
            wSelf.viewController?.navigationController?.popToRootViewController(animated: false)
        })
    }
}

private extension CartRouter {

}

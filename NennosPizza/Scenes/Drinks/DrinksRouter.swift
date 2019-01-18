//
//  DrinksRouter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol DrinksRoutingLogic {

}

class DrinksRouter {
    private weak var viewController: DrinksViewController?

    init(resource: DrinksViewController) {
        viewController = resource
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension DrinksRouter: DrinksRoutingLogic {

}

private extension DrinksRouter {

}

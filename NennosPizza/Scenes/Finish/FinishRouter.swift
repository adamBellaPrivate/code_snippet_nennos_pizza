//
//  FinishRouter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol FinishRoutingLogic {
    func navigateToRoot()
}

class FinishRouter {
    private weak var viewController: FinishViewController?

    init(resource: FinishViewController) {
        viewController = resource
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension FinishRouter: FinishRoutingLogic {
    final func navigateToRoot() {
        viewController?.dismiss(animated: true, completion: .none)
    }
}

private extension FinishRouter {

}

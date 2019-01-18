//
//  HomePresenter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol HomePresentationLogic: class {
    func manageAvailablePizzas(_ pizzas: [CompletePizza])
}

class HomePresenter {
    private weak var view: HomeDisplayLogic?

    init(_ resourceView: HomeDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension HomePresenter: HomePresentationLogic {
    final func manageAvailablePizzas(_ pizzas: [CompletePizza]) {
        view?.showAvailablePizzas(pizzas)
    }
}

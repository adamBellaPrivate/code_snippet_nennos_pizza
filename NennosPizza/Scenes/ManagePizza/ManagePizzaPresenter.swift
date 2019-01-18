//
//  CreatePizzaPresenter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol CreatePizzaPresentationLogic: class {
     func manageAvailableIngredients(_ ingredients: [Ingredient])
     func manageSelectedPizza(_ pizza: CompletePizza?)
}

class ManagePizzaPresenter {
    private weak var view: ManagePizzaDisplayLogic?

    init(_ resourceView: ManagePizzaDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ManagePizzaPresenter: CreatePizzaPresentationLogic {
    final func manageAvailableIngredients(_ ingredients: [Ingredient]) {
        view?.showAvailableIngredients(ingredients)
    }

    final func manageSelectedPizza(_ pizza: CompletePizza?) {
        view?.showPizza(pizza)
    }
}

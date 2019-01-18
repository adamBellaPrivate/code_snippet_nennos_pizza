//
//  DrinksPresenter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol DrinksPresentationLogic: class {
    func manageAvailableDrinks(_ drinks: [Drink])
}

class DrinksPresenter {
    private weak var view: DrinksDisplayLogic?

    init(_ resourceView: DrinksDisplayLogic) {
        view = resourceView
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension DrinksPresenter: DrinksPresentationLogic {
    final func manageAvailableDrinks(_ drinks: [Drink]) {
        view?.showAvailableDrinks(drinks)
    }
}

//
//  CreatePizzaInteractor.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol ManagePizzaBusinessLogic {
    func fetchDataSources()
    func addToCart()
}

protocol ManagePizzaDataStore: class {
    var ingredients: [Ingredient] { get set }
    var pizza: CompletePizza? { get set }
}

class ManagePizzaInteractor: ManagePizzaDataStore {
    var ingredients = [Ingredient]()
    var pizza: CompletePizza?

    private var presenter: CreatePizzaPresentationLogic?
    private let cartWorker: CartWorkerProtocol = CartWorker()

    init(_ resourceView: ManagePizzaDisplayLogic) {
        presenter = ManagePizzaPresenter(resourceView)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ManagePizzaInteractor: ManagePizzaBusinessLogic {
    final func fetchDataSources() {
        presenter?.manageAvailableIngredients(ingredients)
        presenter?.manageSelectedPizza(pizza)
    }

    final func addToCart() {
        guard let wPizza = pizza else { return }
        cartWorker.addProductTo(Cart: wPizza)
    }
}

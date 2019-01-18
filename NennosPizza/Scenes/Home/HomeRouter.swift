//
//  HomeRouter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic {
    func navigateToManagePizza()
    func navigateToCart()
}

private protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeDataPassing {
    private weak var viewController: HomeViewController?
    fileprivate var dataStore: HomeDataStore?

    init(resource: HomeViewController, dataStore: HomeDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension HomeRouter: HomeRoutingLogic {
    final func navigateToCart() {
        navigateTo(destination: CartViewController())
    }

    final func navigateToManagePizza() {
        let managePizzaVC = ManagePizzaViewController()
        var managePizzaDS = managePizzaVC.router.dataStore
        passDataToManagePizza(source: dataStore, destination: &managePizzaDS)
        navigateTo(destination: managePizzaVC)
    }
}

private extension HomeRouter {
    final func passDataToManagePizza(source: HomeDataStore?, destination: inout ManagePizzaDataStore?) {
        destination?.ingredients = source?.ingredients ?? []
        if let pizza = source?.selectedPizza {
            destination?.pizza = pizza
        } else {
            destination?.pizza = CompletePizza(name: "screen.manage_pizza.custom_pizza.name".localized, ingredients: [], basePrice: source?.basePrice ?? 0, imageUrl: .none)
        }
    }

    final func navigateTo(destination: UIViewController) {
        viewController?.show(destination, sender: .none)
    }
}

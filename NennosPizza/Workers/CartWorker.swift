//
//  CartWorker.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct CartWorker: CartWorkerProtocol {
    private let storageWorker: StorageWorkerProtocol = UserDefaultsWorker()

    func addProductTo(Cart product: Product) {
        var tempProduct = product
        let newInternalId = (getProducts().filter({ $0.internalId != .none }).compactMap({ $0.internalId }).sorted().last ?? -1) + 1
        tempProduct.internalId = newInternalId

        if let pizza = tempProduct as? CompletePizza {
            var allPizzas = getPizzasFromCart() as? [CompletePizza] ?? []
            allPizzas.append(pizza)
            savePizzas(allPizzas)
        } else if let drink = tempProduct as? Drink {
            var allDrinks = getDrinksFromCart() as? [Drink] ?? []
            allDrinks.append(drink)
            saveDrinks(allDrinks)
        }
        NotificationCenter.default.post(name: .didAddItemToCart, object: .none)
    }

    @discardableResult func removeProductFrom(Cart product: Product) -> [Product] {
        var products = getProducts()
        guard let foundIndex = products.firstIndex(where: { $0.internalId != .none && $0.internalId == product.internalId }) else { return products }
        products.remove(at: foundIndex)

        savePizzas(products.filter({ $0 is CompletePizza }) as? [CompletePizza] ?? [])
        saveDrinks(products.filter({ $0 is Drink }) as? [Drink] ?? [])

        return products
    }

    func getProducts() -> [Product] {
        return (getPizzasFromCart() + getDrinksFromCart()).sorted(by: {
            guard let internalId0 = $0.internalId else { return false }
            guard let internalId1 = $1.internalId else { return true }
            return internalId0 < internalId1
        })
    }

    func getPizzasFromCart() -> [Product] {
        return storageWorker.getPizzasFromCart()
    }

    func getDrinksFromCart() -> [Product] {
        return storageWorker.getDrinksFromCart()
    }

    func saveDrinks(_ products: [Drink]) {
        storageWorker.saveDrinks(products)
    }

    func savePizzas(_ products: [CompletePizza]) {
        storageWorker.savePizzas(products)
    }

    func clearCart() {
        storageWorker.clearCart()
    }
}

//
//  CartWorkerProtocol.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol CartWorkerProtocol {
    func addProductTo(Cart product: Product)
    @discardableResult func removeProductFrom(Cart product: Product) -> [Product]
    func getProducts() -> [Product]
    func getPizzasFromCart() -> [Product]
    func getDrinksFromCart() -> [Product]
    func saveDrinks(_ products: [Drink])
    func savePizzas(_ products: [CompletePizza])
    func clearCart()
}

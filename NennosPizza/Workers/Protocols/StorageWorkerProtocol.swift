//
//  StorageWorkerProtocol.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol StorageWorkerProtocol {
    func getPizzasFromCart() -> [Product]
    func getDrinksFromCart() -> [Product]
    func saveDrinks(_ products: [Drink])
    func savePizzas(_ products: [CompletePizza])
    func clearCart()
}

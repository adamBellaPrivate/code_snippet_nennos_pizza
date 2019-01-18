//
//  CompletePizza.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/12/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct CompletePizza: Product {
    private(set) var ingredients: [Ingredient] {
        didSet {
            updateIngredientNames()
        }
    }

    let imageUrl: String?
    var ingredientNames: String = ""
    let originalIngredientIds: [Double]
    var internalId: Int?
    var price: Double
    var name: String

    init(name: String, ingredients: [Ingredient], basePrice: Double, imageUrl: String?) {
        originalIngredientIds = ingredients.compactMap({ $0.id })
        self.ingredients = ingredients
        self.imageUrl = imageUrl
        self.name = name
        price = ingredients.reduce(basePrice, { $0 + $1.price })
        updateIngredientNames()
    }

    mutating func addIngredient(by ingredient: Ingredient) {
        guard !ingredients.contains(where: { $0.id == ingredient.id }) else { return }
        ingredients.append(ingredient)
        price += ingredient.price
    }

    mutating func removeIngredient(by ingredient: Ingredient) {
        price = ingredients.filter({ $0.id == ingredient.id }).reduce(price, { $0 - $1.price })
        ingredients.removeAll(where: { $0.id == ingredient.id })
    }

    func containsIngredient(_ ingredient: Ingredient) -> Bool {
        return ingredients.contains(where: { $0.id == ingredient.id })
    }
}

private extension CompletePizza {
    mutating func updateIngredientNames() {
        ingredientNames = ingredients.compactMap({ $0.name }).filter({ !$0.isEmpty }).joined(separator: ", ")
    }
}

//
//  CompletePizzaTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
@testable import NennosPizza

class CompletePizzaTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    final func testIndividualIngredient() {
        var pizza = CompletePizza(name: "Custom Pizza", ingredients: [Ingredient(id: 1, name: "Ingredient", price: 6)], basePrice: 4, imageUrl: .none)

        XCTAssertNotNil(pizza, "Parsing error")
        XCTAssertEqual(pizza.name, "Custom Pizza", "Name mismatch")
        XCTAssertEqual(pizza.originalIngredientIds.count, 1, "Original Ingredient count mismatch")
        XCTAssertEqual(pizza.imageUrl, .none, "ImageUrl mismatch")
        XCTAssertEqual(pizza.price, 10, "Pizza price mismatch")
        XCTAssertEqual(pizza.ingredientNames, "Ingredient", "Pizza price mismatch")

        let ingredient2 = Ingredient(id: 2, name: "Ingredient 2", price: 8)
        pizza.addIngredient(by: ingredient2)
        XCTAssertEqual(pizza.price, 18, "Pizza price mismatch")
        XCTAssertEqual(pizza.ingredientNames, "Ingredient, Ingredient 2", "Pizza price mismatch")
        XCTAssertTrue(pizza.containsIngredient(ingredient2), "Error in containsIngredient function")

        let originalIngredient = pizza.ingredients.first
        XCTAssertNotNil(originalIngredient, "Indexing error")
        pizza.removeIngredient(by: originalIngredient!)
        XCTAssertEqual(pizza.price, 12, "Pizza price mismatch")
        XCTAssertEqual(pizza.ingredientNames, "Ingredient 2", "Pizza price mismatch")
        XCTAssertFalse(pizza.containsIngredient(originalIngredient!), "Error in containsIngredient function")
    }
}

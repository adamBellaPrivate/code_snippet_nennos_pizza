//
//  CartTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
@testable import NennosPizza

class CartTests: XCTestCase {
    private let cartWorker: CartWorkerProtocol = CartWorker()

    override func setUp() {
        super.setUp()
        cartWorker.clearCart()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    final func testCart() {
        cartWorker.addProductTo(Cart: Drink(id: 1, internalId: .none, price: 3, name: "Coke"))
        XCTAssertEqual(cartWorker.getDrinksFromCart().count, cartWorker.getProducts().count)

        cartWorker.addProductTo(Cart: Drink(id: 2, internalId: .none, price: 7, name: "Vodka"))
        cartWorker.addProductTo(Cart: CompletePizza(name: "Custom Pizza", ingredients: [Ingredient(id: 1, name: "Ingredient 1", price: 2), Ingredient(id: 2, name: "Ingredient 2", price: 6)], basePrice: 4, imageUrl: .none))
        XCTAssertEqual(cartWorker.getProducts().count, 3)
        XCTAssertEqual(cartWorker.getPizzasFromCart().count, 1)
        XCTAssertEqual(cartWorker.getDrinksFromCart().count, 2)
        XCTAssertNotNil(cartWorker.getDrinksFromCart().first)

        cartWorker.removeProductFrom(Cart: cartWorker.getDrinksFromCart().first!)
        XCTAssertEqual(cartWorker.getDrinksFromCart().count, 1)
        XCTAssertEqual(cartWorker.getProducts().count, 2)

        let products = cartWorker.getProducts()
        XCTAssertNotNil(products.first, "Missing item")
        XCTAssertEqual(products.first?.name, "Vodka")
        XCTAssertEqual(products.first?.price, 7)
        XCTAssertEqual(products.first?.internalId, 1)

        XCTAssertNotNil(products.last, "Missing item")
        XCTAssertEqual(products.last?.name, "Custom Pizza")
        XCTAssertEqual(products.last?.price, 12)
        XCTAssertEqual(products.last?.internalId, 2)

        cartWorker.clearCart()
        XCTAssertEqual(cartWorker.getProducts().count, 0)
    }
}

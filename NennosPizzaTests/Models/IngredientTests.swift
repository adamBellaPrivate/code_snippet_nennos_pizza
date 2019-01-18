//
//  IngredientTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
@testable import NennosPizza

class IngredientTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    final func testIndividualIngredient() {
        let data = "{\"id\": 12, \"name\": \"Test Ingredient\", \"price\": 870}".data(using: .utf8)
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode(Ingredient.self, from: data!)
        XCTAssertNotNil(response, "Parsing error")
        XCTAssertEqual(response?.name, "Test Ingredient", "Name mismatch")
        XCTAssertEqual(response?.id, 12, "Id mismatch")
        XCTAssertEqual(response?.price, 870, "Price mismatch")

        let data2 = "{\"name\": \"Test Ingredient\", \"price\": 870}".data(using: .utf8)
        XCTAssertNotNil(data2, "JSON error")
        let response2 = try? JSONDecoder().decode(Ingredient.self, from: data2!)
        XCTAssertNil(response2)
    }

    final func testListPizza() {
        let data = "[{\"id\": 12, \"name\": \"Test Ingredient\", \"price\": 870}, {\"id\": 21, \"name\": \"Test Ingredient 2\", \"price\": 1050}]".data(using: .utf8)
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode([Ingredient].self, from: data!)

        // MARK: - First element
        XCTAssertNotNil(response?.first, "Parsing error")
        XCTAssertEqual(response?.first?.name, "Test Ingredient", "Name mismatch")
        XCTAssertEqual(response?.first?.id, 12, "Id mismatch")
        XCTAssertEqual(response?.first?.price, 870, "Price mismatch")

        // MARK: - Last element
        XCTAssertNotNil(response?.last, "Parsing error")
        XCTAssertEqual(response?.last?.name, "Test Ingredient 2", "Name mismatch")
        XCTAssertEqual(response?.last?.id, 21, "Id mismatch")
        XCTAssertEqual(response?.last?.price, 1050, "Price mismatch")
    }
}

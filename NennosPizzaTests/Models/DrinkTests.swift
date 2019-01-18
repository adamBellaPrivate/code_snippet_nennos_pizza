//
//  DrinkTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
@testable import NennosPizza

class DrinkTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    final func testIndividualIngredient() {
        let data = "{\"id\": 1, \"name\": \"Test Drink\", \"price\": 350}".data(using: .utf8)
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode(Drink.self, from: data!)
        XCTAssertNotNil(response, "Parsing error")
        XCTAssertEqual(response?.name, "Test Drink", "Name mismatch")
        XCTAssertEqual(response?.id, 1, "Id mismatch")
        XCTAssertEqual(response?.price, 350, "Price mismatch")

        let data2 = "{\"id\": 1, \"price\": 350}".data(using: .utf8)
        XCTAssertNotNil(data2, "Resource error")
        let response2 = try? JSONDecoder().decode(Drink.self, from: data2!)
        XCTAssertNil(response2)
    }

    final func testListPizza() {
        let data = "[{\"id\": 1, \"name\": \"Test Drink\", \"price\": 350}, {\"id\": 2, \"name\": \"Test Drink 2\", \"price\": 500}]".data(using: .utf8)
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode([Drink].self, from: data!)

        // MARK: - First element
        XCTAssertNotNil(response?.first, "Parsing error")
        XCTAssertEqual(response?.first?.name, "Test Drink", "Name mismatch")
        XCTAssertEqual(response?.first?.id, 1, "Id mismatch")
        XCTAssertEqual(response?.first?.price, 350, "Price mismatch")

        // MARK: - Last element
        XCTAssertNotNil(response?.last, "Parsing error")
        XCTAssertEqual(response?.last?.name, "Test Drink 2", "Name mismatch")
        XCTAssertEqual(response?.last?.id, 2, "Id mismatch")
        XCTAssertEqual(response?.last?.price, 500, "Price mismatch")
    }
}

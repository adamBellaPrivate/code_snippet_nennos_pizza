//
//  PizzaTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
@testable import NennosPizza

class PizzaTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    final func testIndividualPizza() {
        let data = "{\"name\": \"Test Pizza\", \"ingredients\": [1, 123, 2, 3242]}".data(using: .utf8)
        runTestData(data)

        let data2 = "{\"name\": \"Test Pizza\", \"ingredients\": [1, 123, 2, 3242], \"imageUrl\": null}".data(using: .utf8)
        runTestData(data2)

        let data3 = "{\"name\": \"Test Pizza\", \"ingredients\": [1, 123, 2, 3242], \"imageUrl\": \"https://cdn.pbrd.co/images/4O70NDkMl.png\"}".data(using: .utf8)
        runTestData(data3, imageUrl: "https://cdn.pbrd.co/images/4O70NDkMl.png")

        let data4 = "{\"ingredients\": [1, 123, 2, 3242], \"imageUrl\": null}".data(using: .utf8)
        XCTAssertNotNil(data4, "JSON Error")
        let response = try? JSONDecoder().decode(Pizza.self, from: data4!)
        XCTAssertNil(response)
    }

    final func testListPizza() {
        let data = "[ { \"name\": \"Test Pizza\", \"ingredients\": [1, 123, 2, 3242] }, {\"name\": \"Test Pizza 2\", \"ingredients\": [1, 123], \"imageUrl\": \"https://cdn.pbrd.co/images/4O70NDkMl.png\"}]".data(using: .utf8)
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode([Pizza].self, from: data!)

        // MARK: - First element
        XCTAssertNotNil(response?.first, "Parsing error")
        XCTAssertEqual(response?.first?.name, "Test Pizza", "Name mismatch")
        XCTAssertEqual(response?.first?.ingredients, [1, 123, 2, 3242], "Ingredients mismatch")
        XCTAssertEqual(response?.first?.imageUrl, .none, "ImageUrl mismatch")

        // MARK: - Last element
        XCTAssertNotNil(response?.last, "Parsing error")
        XCTAssertEqual(response?.last?.name, "Test Pizza 2", "Name mismatch")
        XCTAssertEqual(response?.last?.ingredients, [1, 123], "Ingredients mismatch")
        XCTAssertEqual(response?.last?.imageUrl, "https://cdn.pbrd.co/images/4O70NDkMl.png", "ImageUrl mismatch")
    }

    private final func runTestData(_ data: Data?, imageUrl: String? = .none) {
        XCTAssertNotNil(data, "Resource error")
        let response = try? JSONDecoder().decode(Pizza.self, from: data!)
        XCTAssertNotNil(response, "Parsing error")
        XCTAssertEqual(response?.name, "Test Pizza", "Name mismatch")
        XCTAssertEqual(response?.ingredients, [1, 123, 2, 3242], "Ingredients mismatch")
        XCTAssertEqual(response?.imageUrl, imageUrl, "ImageUrl mismatch")
    }
}

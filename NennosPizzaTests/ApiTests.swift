//
//  ApiTests.swift
//  NennosPizzaTests
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
import RxAlamofire
import RxSwift
@testable import NennosPizza

class ApiTests: XCTestCase {
    private let apiWorker: ApiWorkerProtocol = ApiWorker()
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = DisposeBag()
    }

    final func testFetchPizzas() {
        Observable.zip(apiWorker.fetchPizzas(), apiWorker.fetchIngredients()) { (pizzasResult, ingredientsResult) -> ManagedPizzaResponse in

            if case .failure(let error) = pizzasResult {
                XCTFail("Pizza api error: \(error.localizedDescription)")
            }

            if case .failure(let error) = ingredientsResult {
                XCTFail("Ingredients api error: \(error.localizedDescription)")
            }

            guard case .success(let pizzas) = pizzasResult,
                case .success(let ingredients) = ingredientsResult else { return ManagedPizzaResponse([], [], 0)}

            let completePizzas = pizzas.pizzas.compactMap({ (pizza) -> CompletePizza in
                return CompletePizza(name: pizza.name, ingredients: ingredients.filter({ pizza.ingredients.contains($0.id) }), basePrice: pizzas.basePrice, imageUrl: pizza.imageUrl)
            }).sorted(by: { $0.name < $1.name })

            XCTAssertEqual(completePizzas.count, pizzas.pizzas.count, "The code didn't parse every Pizza objects to CompletePizza objects")

            return ManagedPizzaResponse(completePizzas, ingredients, pizzas.basePrice)
            }.asDriver(onErrorJustReturn: ManagedPizzaResponse([], [], 0)).drive(onNext: { (_) in

            }).disposed(by: disposeBag)
    }

    final func testFetchDrinks() {
        apiWorker.fetchDrinks().asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse)).drive(onNext: { (result) in
            if case .failure(let error) = result {
                XCTFail("Drinks api error: \(error.localizedDescription)")
            }

        }).disposed(by: disposeBag)
    }

    final func testOrderProducts() {
        apiWorker.orderProducts(pizzas: [Pizza(name: "Custom Pizza 1", ingredients: [1, 2, 3], imageUrl: .none), Pizza(name: "Custom Pizza 2", ingredients: [1, 5, 3, 9], imageUrl: .none)], drinks: [1, 2]).asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse)).drive(onNext: { (response) in

            if case .failure(let error) = response {
                XCTFail("Drinks api error: \(error.localizedDescription)")
            }

        }).disposed(by: disposeBag)
    }
}

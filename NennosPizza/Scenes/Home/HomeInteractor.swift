//
//  HomeInteractor.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ProgressHUD

protocol HomeBusinessLogic {
    func fetchPizzas()
    func addToCart()
}

protocol HomeDataStore: class {
    var ingredients: [Ingredient] { get }
    var basePrice: Double { get }
    var selectedPizza: CompletePizza? { get set }
}

typealias ManagedPizzaResponse = (pizzas: [CompletePizza], ingredients: [Ingredient], basePrice: Double)

class HomeInteractor: HomeDataStore {
    var basePrice = 0.0
    var ingredients = [Ingredient]()
    var selectedPizza: CompletePizza?

    private var presenter: HomePresentationLogic?
    private let apiWorker: ApiWorkerProtocol = ApiWorker()
    private let cartWorker: CartWorkerProtocol = CartWorker()
    private var disposeBag = DisposeBag()

    init(_ resourceView: HomeDisplayLogic) {
        presenter = HomePresenter(resourceView)
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension HomeInteractor: HomeBusinessLogic {
    final func fetchPizzas() {
        ProgressHUD.show()
        Observable.zip(apiWorker.fetchPizzas(), apiWorker.fetchIngredients()) { (pizzasResult, ingredientsResult) -> ManagedPizzaResponse in
            guard case .success(let pizzas) = pizzasResult,
                case .success(let ingredients) = ingredientsResult else { return ManagedPizzaResponse([], [], 0)}

            let completePizzas = pizzas.pizzas.compactMap({ (pizza) -> CompletePizza in
                return CompletePizza(name: pizza.name, ingredients: ingredients.filter({ pizza.ingredients.contains($0.id) }), basePrice: pizzas.basePrice, imageUrl: pizza.imageUrl)
            })

            return ManagedPizzaResponse(completePizzas, ingredients, pizzas.basePrice)
            }.asDriver(onErrorJustReturn: ManagedPizzaResponse([], [], 0)).drive(onNext: { [weak self] (result) in
                guard let wSelf = self else {return}
                ProgressHUD.dismiss()
                wSelf.ingredients = result.ingredients
                wSelf.basePrice = result.basePrice
                wSelf.presenter?.manageAvailablePizzas(result.pizzas)
            }).disposed(by: disposeBag)
    }

    final func addToCart() {
        guard let wPizza = selectedPizza else { return }
        cartWorker.addProductTo(Cart: wPizza)
    }
}

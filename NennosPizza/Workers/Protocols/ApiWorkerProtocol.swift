//
//  ApiWorkerProtocol.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiWorkerProtocol {
    func fetchPizzas() -> Observable<ApiWorker.Result<PizzaListResponse>>
    func fetchIngredients() -> Observable<ApiWorker.Result<[Ingredient]>>
    func fetchDrinks() -> Observable<ApiWorker.Result<[Drink]>>
    func orderProducts(pizzas: [Pizza], drinks: [Double]) -> Observable<ApiWorker.Result<BaseResponse>>
}

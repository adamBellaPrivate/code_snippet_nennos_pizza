//
//  ApiWorker.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

protocol ApiRequestProtocol {
    var urlPath: ApiUtils.ApiPath { get }
    var method: HTTPMethod {get}
}

struct ApiWorker: ApiWorkerProtocol {
    public enum Result<Value> {
        case success(Value)
        case failure(Error)
    }

    public typealias ResultCallback<Value> = (Result<Value>) -> Void
    private static let successStatusCodes: Set<Int> = Set(200...299)

    func fetchPizzas() -> Observable<Result<PizzaListResponse>> {
        return createCall(PizzaListRequest(), responseType: PizzaListResponse.self)
    }

    func fetchIngredients() -> Observable<Result<[Ingredient]>> {
        return createCall(IngredientListRequest(), responseType: [Ingredient].self)
    }

    func fetchDrinks() -> Observable<Result<[Drink]>> {
        return createCall(DrinkListRequest(), responseType: [Drink].self)
    }

    func orderProducts(pizzas: [Pizza], drinks: [Double]) -> Observable<Result<BaseResponse>> {
        return createCall(OrderProductsRequest(pizzas: pizzas, drinks: drinks), responseType: BaseResponse.self)
    }
}

private extension ApiWorker {
    private var defaultHeaders: [String: String] {
        return [ "Accept": "application/json" ]
    }

    func createCall<U: ApiRequestProtocol & BaseRequestProtocol, T: Decodable>(_ request: U, responseType: T.Type) -> Observable<Result<T>> {
        return RxAlamofire.requestData(request.method, request.urlPath.url, parameters: request.params(), encoding: URLEncoding.httpBody, headers: defaultHeaders).map { (urlResponse, data) -> Result<T> in
            print("End WS call \(request.urlPath.url) with status code: \(urlResponse.statusCode)")
            if ApiWorker.successStatusCodes.contains(urlResponse.statusCode) {
                do {
                    let response = try JSONDecoder().decode(responseType, from: data)
                    return Result.success(response)
                } catch {
                    return Result.failure(ErrorWorker.ApiError.invalidResponse)
                }
            } else {
                return Result.failure(ErrorWorker.ApiError.businessError(urlResponse.statusCode))
            }
            }.catchError({ (error) -> Observable<Result<T>> in
                return Observable.just(Result.failure(error))
            })
    }
}

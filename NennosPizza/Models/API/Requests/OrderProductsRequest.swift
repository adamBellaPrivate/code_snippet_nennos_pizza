//
//  OrderProductsRequest.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

class OrderProductsRequest: BaseRequest {
    let pizzas: [Pizza]
    let drinks: [Double]

    init(urlPath: ApiUtils.ApiPath = .order, method: HTTPMethod = .post, pizzas: [Pizza], drinks: [Double]) {
        self.pizzas = pizzas
        self.drinks = drinks
        super.init(urlPath: urlPath, method: method)
    }

    private enum ChildCodingKeys: String, CodingKey {
        case pizzas, drinks
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildCodingKeys.self)
        try container.encodeIfPresent(pizzas, forKey: .pizzas)
        try container.encodeIfPresent(drinks, forKey: .drinks)
        try super.encode(to: encoder)
    }
}

//
//  PizzaListResponse.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct PizzaListResponse: Codable {
    let pizzas: [Pizza]
    let basePrice: Double
}

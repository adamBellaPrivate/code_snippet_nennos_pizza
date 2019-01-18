//
//  Constant.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct Constant {
    struct ApplicationURLs {
        static let apiBaseGetterURL = URL(string: "https://api.myjson.com/bins/")!
        static let apiPostURL = URL(string: "http://httpbin.org/post")!
    }

    enum UserDefaultsKeys: String {
        case cartPizzasKey = "PizzasInCart"
        case cartDrinksKey = "DrinksInCart"
    }
}

//
//  ApiUtils.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

struct ApiUtils {
    static var contentType: [String: String] = {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }()

    enum ApiPath {
        case ingredients
        case drinks
        case pizzas
        case order

        var url: URLConvertible {
            switch self {
            case .ingredients: return ApiUtils.apiURL(by: "ozt3z")
            case .drinks: return ApiUtils.apiURL(by: "150da7")
            case .pizzas: return ApiUtils.apiURL(by: "dokm7")
            case .order: return Constant.ApplicationURLs.apiPostURL
            }
        }
    }

    static func apiURL(by path: String) -> URLConvertible {
        return Constant.ApplicationURLs.apiBaseGetterURL.appendingPathComponent(path)
    }
}

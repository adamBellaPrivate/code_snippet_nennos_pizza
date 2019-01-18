//
//  DrinkListRequest.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire

class DrinkListRequest: BaseRequest {
    override init(urlPath: ApiUtils.ApiPath = .drinks, method: HTTPMethod = .get) {
        super.init(urlPath: urlPath, method: method)
    }
}

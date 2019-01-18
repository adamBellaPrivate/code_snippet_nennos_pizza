//
//  Pizza.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct Pizza: Codable {
    let name: String
    let ingredients: [Double]
    let imageUrl: String?
}

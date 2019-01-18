//
//  Product.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol Product: Codable {
    var internalId: Int? { get set }
    var name: String { get }
    var price: Double { get set }
}

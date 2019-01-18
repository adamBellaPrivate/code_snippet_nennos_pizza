//
//  ManagePizzaRouter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol ManagePizzaRoutingLogic {

}

protocol ManagePizzaDataPassing {
    var dataStore: ManagePizzaDataStore? { get }
}

class ManagePizzaRouter: ManagePizzaDataPassing {
    private weak var viewController: ManagePizzaViewController?
    var dataStore: ManagePizzaDataStore?

    init(resource: ManagePizzaViewController, dataStore: ManagePizzaDataStore?) {
        viewController = resource
        self.dataStore = dataStore
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ManagePizzaRouter: ManagePizzaRoutingLogic {

}

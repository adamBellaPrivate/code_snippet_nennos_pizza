//
//  NotificationRootInteractor.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol NotificationRootBusinessLogic {

}

class NotificationRootInteractor {
    private var presenter: NotificationRootPresentationLogic?

    init(_ resourceView: NotificationRootDisplayLogic) {
        presenter = NotificationRootPresenter(resourceView)
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension NotificationRootInteractor: NotificationRootBusinessLogic {

}

//
//  NotificationRootPresenter.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

protocol NotificationRootPresentationLogic: class {
    func showNotification()
}

class NotificationRootPresenter {
    private weak var view: NotificationRootDisplayLogic?
    private var notificationObserver: NSObjectProtocol?

    init(_ resourceView: NotificationRootDisplayLogic) {
        view = resourceView

        notificationObserver = NotificationCenter.default.addObserver(forName: .didAddItemToCart, object: .none, queue: .main) { [weak self] (_) in
            guard let wSelf = self else { return }
            wSelf.showNotification()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(notificationObserver as Any)
        NSLog("Deinit: \(type(of: self))")
    }
}

extension NotificationRootPresenter: NotificationRootPresentationLogic {
    final func showNotification() {
        view?.showNotification()
    }
}

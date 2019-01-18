//
//  NotificationRootViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

protocol NotificationRootDisplayLogic: class {
     func showNotification()
}

class NotificationRootViewController: UIViewController {
    private static let notificationVisibilityTime: TimeInterval = 3

    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var constraintNotificationHeight: NSLayoutConstraint!
    @IBOutlet private weak var lblNotificationMessage: UILabel! {
        didSet {
            lblNotificationMessage.text = "notification.message".localized.uppercased()
            lblNotificationMessage.textColor = AppTheme.secondaryText
            lblNotificationMessage.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            lblNotificationMessage.applyTextSpacing(value: -0.29)
        }
    }

    private var countDownTimer: Timer?
    private var interactor: NotificationRootBusinessLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

extension NotificationRootViewController: NotificationRootDisplayLogic {
    final func showNotification() {
        constraintNotificationHeight.constant = 20 + UIApplication.safeAreInset(by: .top)
        playAnimation()
        countDownTimer?.invalidate()
        countDownTimer = Timer.scheduledTimer(timeInterval: NotificationRootViewController.notificationVisibilityTime, target: self, selector: #selector(NotificationRootViewController.hideNotification), userInfo: .none, repeats: false)
    }
}

private extension NotificationRootViewController {
    final func setupScreenAppearance() {
        let childViewController = UINavigationController(rootViewController: HomeViewController())
        childViewController.interactivePopGestureRecognizer?.isEnabled = true
        addChild(childViewController)
        childViewController.view.show(in: viewContainer)
        childViewController.didMove(toParent: self)
        interactor = NotificationRootInteractor(self)
    }

    // MARK: Controls
    @objc final func hideNotification() {
        constraintNotificationHeight.constant = 0
        playAnimation()
        countDownTimer?.invalidate()
    }

    final func playAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

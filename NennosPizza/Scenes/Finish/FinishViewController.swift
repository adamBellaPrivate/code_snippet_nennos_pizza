//
//  FinishViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    private lazy var router: FinishRoutingLogic = FinishRouter(resource: self)

    @IBOutlet private weak var viewBottomLayer: UIView! {
        didSet {
            viewBottomLayer.backgroundColor = AppTheme.redBtnBackground
        }
    }
    @IBOutlet private weak var lblMessage: UILabel! {
        didSet {
            lblMessage.textColor = AppTheme.finishMessageText
            lblMessage.text = "screen.finish.message".localized
            lblMessage.font = UIFont.italicSystemFont(ofSize: 34)
            lblMessage.applyTextSpacing(value: -0.82)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
    }

    deinit {
        NSLog("Deinit: \(type(of: self))")
    }
}

private extension FinishViewController {
    final func setupScreenAppearance() {
        view.addTapGesture(self, action: #selector(FinishViewController.closeProccess))
    }

    @objc final func closeProccess() {
        router.navigateToRoot()
    }
}

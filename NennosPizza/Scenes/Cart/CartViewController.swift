//
//  CartViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CartDisplayLogic: class {
    func showCartContent(_ products: [Product])
    func showPurchaseSuccessResult()
}

class CartViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: CartTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: CartTableViewCell.reuseIdentifier)
        }
    }
    @IBOutlet private weak var btnCheckout: UIButton! {
        didSet {
            btnCheckout.setTitle("screen.cart.btn_checkout.title".localized.uppercased(), for: .normal)
            btnCheckout.titleLabel?.applyTextSpacing(value: -0.39)
            btnCheckout.applyRedStyle()
        }
    }
    @IBOutlet private weak var lblEmptyMessage: UILabel! {
        didSet {
            lblEmptyMessage.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            lblEmptyMessage.text = "screen.cart.empty_list_message".localized
            lblEmptyMessage.textColor = AppTheme.primaryText
            lblEmptyMessage.applyTextSpacing(value: -0.41)
        }
    }
    @IBOutlet private weak var viewEmptyList: UIView!

    private lazy var interactor: CartBusinessLogic = CartInteractor(self)
    private lazy var router: CartRoutingLogic = CartRouter(resource: self)

    private var dataSource = BehaviorRelay<[Product]>(value: [])
    private var disposeBag = DisposeBag()
    private let footerView = CartFooterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        subscribeToDataSource()
        interactor.fetchCartContent()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension CartViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

private extension CartViewController {
    final func setupScreenAppearance() {
        tableView.tableFooterView = footerView
        navigationItem.title = "screen.cart.title".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_drinks"), style: .plain, target: self, action: #selector(CartViewController.openDrinks))
        clearBackTitle()
        updateCheckoutButton()
        updateTotalAmount()
        updateEmptyListHolder()
    }

    final func subscribeToDataSource() {
        dataSource.share().bind(to: tableView.rx.items(cellIdentifier: CartTableViewCell.reuseIdentifier, cellType: CartTableViewCell.self)) { [weak self]  _, model, cell in

            cell.setupCell(by: model, onComplition: { [weak self] (product) in
                guard let wSelf = self else { return }
                wSelf.interactor.removeProduct(product)
            })

        }.disposed(by: disposeBag)

        dataSource.share().bind { [weak self] (_) in
            guard let wSelf = self else { return }
            wSelf.updateCheckoutButton()
            wSelf.updateTotalAmount()
            wSelf.updateEmptyListHolder()
        }.disposed(by: disposeBag)
    }

    final func updateCheckoutButton() {
        btnCheckout.applyEnableStyle(by: !dataSource.value.isEmpty)
    }

    final func updateTotalAmount() {
        footerView.configureFooter(dataSource.value.reduce(0, { $0 + $1.price }))
    }

    final func updateEmptyListHolder() {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewEmptyList.alpha = self.dataSource.value.isEmpty ? 1 : 0
        })
    }

    @IBAction final func actionCheckout(_ sender: Any) {
        interactor.performCheckout()
    }

    @objc final func openDrinks() {
        router.navigateToDrinks()
    }
}

extension CartViewController: CartDisplayLogic {
    final func showCartContent(_ products: [Product]) {
        dataSource.accept(products)
    }

    final func showPurchaseSuccessResult() {
        router.navigateToSuccessFinish()
    }
}

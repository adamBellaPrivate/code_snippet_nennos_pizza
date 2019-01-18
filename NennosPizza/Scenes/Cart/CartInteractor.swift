//
//  CartInteractor.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ProgressHUD

protocol CartBusinessLogic {
    func fetchCartContent()
    func performCheckout()
    func removeProduct(_ product: Product)
}

class CartInteractor {
    private var presenter: CartPresentationLogic?
    private let cartWorker: CartWorkerProtocol = CartWorker()
    private let apiWorker: ApiWorkerProtocol = ApiWorker()
    private var disposeBag = DisposeBag()
    private var notificationObserver: NSObjectProtocol?

    init(_ resourceView: CartDisplayLogic) {
        presenter = CartPresenter(resourceView)

        notificationObserver = NotificationCenter.default.addObserver(forName: .didAddItemToCart, object: .none, queue: .main) { [weak self] (_) in
            guard let wSelf = self else { return }
            wSelf.fetchCartContent()
        }
    }

    deinit {
        disposeBag = DisposeBag()
        NotificationCenter.default.removeObserver(notificationObserver as Any)
        NSLog("Deinit: \(type(of: self))")
    }
}

extension CartInteractor: CartBusinessLogic {
    final func fetchCartContent() {
        presenter?.manageCartContent(cartWorker.getProducts())
    }

    final func performCheckout() {
        ProgressHUD.show()

        let drinks = (cartWorker.getDrinksFromCart().filter({ $0 is Drink }) as? [Drink] ?? []).compactMap({ $0.id })
        let pizzas = (cartWorker.getPizzasFromCart().filter({ $0 is CompletePizza }) as? [CompletePizza] ?? []).compactMap({ Pizza(name: $0.name, ingredients: $0.ingredients.compactMap({ $0.id }), imageUrl: $0.imageUrl)})

        apiWorker.orderProducts(pizzas: pizzas, drinks: drinks).asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse)).drive(onNext: { [weak self] (response) in
            guard let wSelf = self else { return }
            ProgressHUD.dismiss()
            guard case .success(_) = response else { return }
            wSelf.cartWorker.clearCart()
            wSelf.presenter?.managePurchaseSuccessResult()
        }).disposed(by: disposeBag)
    }

    final func removeProduct(_ product: Product) {
         presenter?.manageCartContent(cartWorker.removeProductFrom(Cart: product))
    }
}

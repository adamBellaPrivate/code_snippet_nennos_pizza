//
//  DrinksInteractor.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import ProgressHUD

protocol DrinksBusinessLogic {
    func fetchDrinks()
    func addToCart(_ drink: Drink)
}

class DrinksInteractor {
    private var presenter: DrinksPresentationLogic?
    private let cartWorker: CartWorkerProtocol = CartWorker()
    private let apiWorker: ApiWorkerProtocol = ApiWorker()
    private var disposeBag = DisposeBag()

    init(_ resourceView: DrinksDisplayLogic) {
        presenter = DrinksPresenter(resourceView)
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension DrinksInteractor: DrinksBusinessLogic {
    final func fetchDrinks() {
        ProgressHUD.show()
        apiWorker.fetchDrinks().asDriver(onErrorJustReturn: ApiWorker.Result.failure(ErrorWorker.ApiError.invalidResponse)).drive(onNext: { [weak self] (result) in
            guard let wSelf = self else {return}
            ProgressHUD.dismiss()
            guard case .success(let drinks) = result else {return}
            wSelf.presenter?.manageAvailableDrinks(drinks)
        }).disposed(by: disposeBag)
    }

    final func addToCart(_ drink: Drink) {
        cartWorker.addProductTo(Cart: drink)
    }
}

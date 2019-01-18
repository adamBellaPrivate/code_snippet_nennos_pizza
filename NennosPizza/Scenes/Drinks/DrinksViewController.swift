//
//  DrinksViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DrinksDisplayLogic: class {
    func showAvailableDrinks(_ drinks: [Drink])
}

class DrinksViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DrinkTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: DrinkTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView()
            tableView.addSubview(refreshControl)
        }
    }

    private lazy var interactor: DrinksBusinessLogic = DrinksInteractor(self)
    private lazy var router: DrinksRoutingLogic = DrinksRouter(resource: self)
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DrinksViewController.handleRefresh), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = AppTheme.refreshControlTint
        return refreshControl
    }()

    private var dataSource = BehaviorRelay<[Drink]>(value: [])
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        subscribeToDataSource()
        interactor.fetchDrinks()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension DrinksViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

private extension DrinksViewController {
    final func setupScreenAppearance() {
        navigationItem.title = "screen.drinks.title".localized
        clearBackTitle()
    }

    final func subscribeToDataSource() {
        dataSource.share().bind(to: tableView.rx.items(cellIdentifier: DrinkTableViewCell.reuseIdentifier, cellType: DrinkTableViewCell.self)) { _, model, cell in
            cell.setupCell(by: model)
        }.disposed(by: disposeBag)

        dataSource.share().bind { [weak self] (_) in
            guard let wSelf = self else { return }
            wSelf.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Drink.self).subscribe(onNext: { [weak self] drink in
            guard let wSelf = self else { return }
            wSelf.interactor.addToCart(drink)
        }).disposed(by: disposeBag)
    }

    @objc final func handleRefresh() {
        interactor.fetchDrinks()
    }
}

extension DrinksViewController: DrinksDisplayLogic {
    final func showAvailableDrinks(_ drinks: [Drink]) {
        dataSource.accept(drinks)
    }
}

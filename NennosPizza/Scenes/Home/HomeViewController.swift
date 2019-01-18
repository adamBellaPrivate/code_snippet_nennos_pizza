//
//  HomeViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/11/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeDisplayLogic: class {
    func showAvailablePizzas(_ pizzas: [CompletePizza])
}

class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: PizzaTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: PizzaTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView()
            tableView.addSubview(refreshControl)
        }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.handleRefresh), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = AppTheme.refreshControlTint
        return refreshControl
    }()
    private lazy var interactor: HomeBusinessLogic & HomeDataStore = HomeInteractor(self)
    private lazy var router: HomeRoutingLogic = HomeRouter(resource: self, dataStore: interactor)

    private var dataSource = BehaviorRelay<[CompletePizza]>(value: [])
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        subscribeToDataSource()
        interactor.fetchPizzas()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension HomeViewController: HomeDisplayLogic {
    final func showAvailablePizzas(_ pizzas: [CompletePizza]) {
        dataSource.accept(pizzas)
    }
}

extension HomeViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PizzaTableViewCell.cellHeight
    }
}

private extension HomeViewController {
    final func setupScreenAppearance() {
        navigationItem.title = "screen.home.title".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_cart_navbar"), style: .done, target: self, action: #selector(HomeViewController.openCart))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(HomeViewController.createPizza))
        clearBackTitle()
    }

    final func subscribeToDataSource() {
        dataSource.share().bind(to: tableView.rx.items(cellIdentifier: PizzaTableViewCell.reuseIdentifier, cellType: PizzaTableViewCell.self)) { [weak self] _, model, cell in
            cell.setupCell(by: model, onComplition: { [weak self] (selectedPizza) in
                guard let wSelf = self else { return }
                wSelf.interactor.selectedPizza = selectedPizza
                wSelf.interactor.addToCart()
            })
        }.disposed(by: disposeBag)

        dataSource.share().bind { [weak self] (_) in
            guard let wSelf = self else { return }
            wSelf.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(CompletePizza.self).subscribe(onNext: { [weak self] pizza in
            guard let wSelf = self else { return }
            wSelf.interactor.selectedPizza = pizza
            wSelf.router.navigateToManagePizza()
        }).disposed(by: disposeBag)
    }

    @objc final func openCart() {
        router.navigateToCart()
    }

    @objc final func createPizza() {
        interactor.selectedPizza = .none
        router.navigateToManagePizza()
    }

    @objc final func handleRefresh() {
        interactor.fetchPizzas()
    }
}

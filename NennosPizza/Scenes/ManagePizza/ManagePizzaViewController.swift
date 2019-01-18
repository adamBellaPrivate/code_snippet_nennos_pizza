//
//  ManagePizzaViewController.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ManagePizzaDisplayLogic: class {
     func showAvailableIngredients(_ ingredients: [Ingredient])
     func showPizza(_ pizza: CompletePizza?)
}

class ManagePizzaViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: IngredientChooserTableViewCell.reuseIdentifier, bundle: .none), forCellReuseIdentifier: IngredientChooserTableViewCell.reuseIdentifier)
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        }
    }
    @IBOutlet private weak var btnAddToCart: UIButton! {
        didSet {
            btnAddToCart.applyYellowStyle()
        }
    }

    private lazy var interactor: ManagePizzaBusinessLogic & ManagePizzaDataStore = ManagePizzaInteractor(self)
    lazy var router: ManagePizzaRoutingLogic & ManagePizzaDataPassing = ManagePizzaRouter(resource: self, dataStore: interactor)

    private var dataSource = BehaviorRelay<[Ingredient]>(value: [])
    private let headerView = ManagePizzaHeaderView()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenAppearance()
        subscribeToDataSource()
        interactor.fetchDataSources()
    }

    deinit {
        disposeBag = DisposeBag()
        NSLog("Deinit: \(type(of: self))")
    }
}

extension ManagePizzaViewController: ManagePizzaDisplayLogic {
    final func showAvailableIngredients(_ ingredients: [Ingredient]) {
        dataSource.accept(ingredients)
    }

    final func showPizza(_ pizza: CompletePizza?) {
        if !(pizza?.originalIngredientIds.isEmpty ?? false) {
            title = pizza?.name.uppercased()
        } else {
            title = "screen.create_pizza.title".localized
        }
        headerView.configureHeaderView(by: pizza?.imageUrl, isCustomPizza: pizza?.originalIngredientIds.isEmpty ?? true)
        updateCartButton()
    }
}

extension ManagePizzaViewController: UITableViewDelegate {
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

private extension ManagePizzaViewController {
    final func setupScreenAppearance() {
        tableView.tableHeaderView = headerView
        updateCartButton()
    }

    final func subscribeToDataSource() {
        dataSource.share().bind(to: tableView.rx.items(cellIdentifier: IngredientChooserTableViewCell.reuseIdentifier, cellType: IngredientChooserTableViewCell.self)) { [weak self] _, model, cell in
            cell.setupCell(by: model, isSelected: self?.interactor.pizza?.containsIngredient(model) ?? false)
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Ingredient.self).subscribe(onNext: { [weak self] ingredient in
            guard let wSelf = self else { return }
            if !(wSelf.interactor.pizza?.containsIngredient(ingredient) ?? false) {
                wSelf.interactor.pizza?.addIngredient(by: ingredient)
            } else {
                wSelf.interactor.pizza?.removeIngredient(by: ingredient)
            }

            wSelf.updateCartButton()

            guard let selectedRowIndexPath = wSelf.tableView.indexPathForSelectedRow else { return }
            wSelf.tableView.reloadRows(at: [selectedRowIndexPath], with: .automatic)
        }).disposed(by: disposeBag)
    }

    final func updateCartButton() {
        btnAddToCart.setTitle(Formatter.formatterAmount.string(from: NSNumber(value: interactor.pizza?.price ?? 0.0)), for: .normal)
        btnAddToCart.titleLabel?.applyTextSpacing(value: -0.39)
        btnAddToCart.applyEnableStyle(by: !(interactor.pizza?.ingredients.isEmpty ?? true))
    }

    @IBAction final func actionAddToCart(_ sender: Any) {
        interactor.addToCart()
    }
}

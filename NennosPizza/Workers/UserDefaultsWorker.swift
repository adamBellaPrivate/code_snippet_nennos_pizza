//
//  UserDefaultsWorker.swift
//  NennosPizza
//
//  Created by Adam Bella on 1/17/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct UserDefaultsWorker: StorageWorkerProtocol {
    private let userDefaults = UserDefaults.standard

    func getPizzasFromCart() -> [Product] {
        guard let data = getObject(.cartPizzasKey) as? Data else { return []}
        do {
            return try JSONDecoder().decode([CompletePizza].self, from: data)
        } catch {
            return []
        }
    }

    func getDrinksFromCart() -> [Product] {
        guard let data = getObject(.cartDrinksKey) as? Data else { return []}
        do {
            return try JSONDecoder().decode([Drink].self, from: data)
        } catch {
            return []
        }
    }

    func saveDrinks(_ products: [Drink]) {
        do {
            let archived = try JSONEncoder().encode(products)
            saveObject(archived, key: .cartDrinksKey)
        } catch {}
    }

    func savePizzas(_ products: [CompletePizza]) {
        do {
            let archived = try JSONEncoder().encode(products)
            saveObject(archived, key: .cartPizzasKey)
        } catch {}
    }

    func clearCart() {
        removeObjects([.cartDrinksKey, .cartPizzasKey])
    }
}

private extension UserDefaultsWorker {
    // MARK: - Base user Defaults
    func saveObject(_ object: Any, key: Constant.UserDefaultsKeys) {
        userDefaults.set(object, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func getObject(_ key: Constant.UserDefaultsKeys) -> Any? {
        return userDefaults.object(forKey: key.rawValue) as Any?
    }

    func removeObject(_ key: Constant.UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func removeObjects(_ keys: [Constant.UserDefaultsKeys]) {
        keys.forEach({ userDefaults.removeObject(forKey: $0.rawValue) })
        userDefaults.synchronize()
    }
}

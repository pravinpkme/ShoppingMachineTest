//
//  HomeViewModel.swift
//  ShoppingAppMachineTest
//
//  Created by Pravin Kumar on 02/02/24.
//

import Foundation
import Foundation

class HomeViewModel {
    var cartItems: [Item] = []
    var favItems: [Item] = []
    var itemsData: ItemsModel?
    
    private let apiManager = JsonManager.shared
    var shoppingModel: ItemsModel?
    
    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
        apiManager.fetchShoppingData { result in
            switch result {
            case .success(let model):
                self.shoppingModel = model
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addToCart(item: Item) {
        if !cartItems.contains(where: { existingItem in
            return existingItem.id == item.id
        }) {
            cartItems.append(item)
        }
    }
    
    func addToFavorites(item: Item, canAddorRemove: Bool) {
        if canAddorRemove {
            if !favItems.contains(where: { existingItem in
                return existingItem.id == item.id
            }) {
                print("added")
                favItems.append(item)
            }
        } else {
            favItems.removeAll { existingItem in
                return existingItem.id == item.id
            }
        }
    }
    
}

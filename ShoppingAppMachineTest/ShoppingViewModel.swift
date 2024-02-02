//
//  ShoppingViewModel.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation

class ShoppingViewModel {
    
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
}

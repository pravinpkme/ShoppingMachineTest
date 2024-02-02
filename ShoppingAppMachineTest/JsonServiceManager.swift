//
//  JsonServiceManager.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation



enum APIError: Error {
    case invalidURL
    case invalidResponse
    case badRequest
    case nilData
    case decodingError(Error)
    case customError(String)
    case serverError(String)
}

class JsonManager {
    static let shared = JsonManager()
    
    func fetchShoppingData(completion: @escaping (Result<ItemsModel, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "items", withExtension: "json") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let shoppingModel = try JSONDecoder().decode(ItemsModel.self, from: data)
            completion(.success(shoppingModel))
        } catch {
            completion(.failure(error))
        }
    }
}

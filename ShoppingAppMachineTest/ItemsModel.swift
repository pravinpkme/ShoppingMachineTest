//
//  ItemsModel.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation

struct ItemsModel: Codable {
    let status: Bool
    let message: String
    let error: String?
    let categories: [Categories]
}

struct Categories: Codable {
    let id: Int
    let name: String
    let items: [Item]?
}

struct Item: Codable {
    let id: Int
    let name: String
    let icon: String
    let price: Double
}

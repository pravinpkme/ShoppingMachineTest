//
//  CartViewController.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation
import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartItems: [Item] = []
 //   var coreDataHandler = CoreDataHandler.shared

    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var checkoutTotalbackroundView: UIView!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var checkoutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cart"
        checkoutTotalbackroundView.layer.cornerRadius = 10
        checkoutTotalbackroundView.layer.masksToBounds = true
        checkoutBtn.layer.cornerRadius = 10
        checkoutBtn.layer.masksToBounds = true
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        self.cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let cartItem = cartItems[indexPath.row]
        cell.configure(with: cartItem)
        cell.priceUpdateClosure = { [weak self] in
            
            self?.updateLabels()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateLabels() {
        var subtotal: Int = 0
        
        for item in cartItems {
            subtotal += Int(item.price)
        }
        
        let discount = subtotal % 100
        let total = subtotal - discount
        
        subTotalLbl.text = " ₹\(subtotal)"
        discountLbl.text = "₹\(discount)"
        totalLabel.text = "₹\(total)"
        
//        for item in cartItems {
//            coreDataHandler.saveItem(id: item.id, name: item.name, icon: item.icon, price: item.price)
//        }
        
        let fetchedResult = fetchAndPrintAllItems()
//        for item in fetchedResult {
//                    print("ID: \(item.id), Name: \(item.name ?? ""), Icon: \(item.icon ?? ""), Price: \(item.price)")
//        }
        
       
    }
    
    
    func fetchAndPrintAllItems() {
           // let allItems = coreDataHandler.fetchAllItems()

//            print("All Items in Core Data:")
//            for item in allItems {
//                print("ID: \(item.id), Name: \(item.name ?? ""), Icon: \(item.icon ?? ""), Price: \(item.price)")
//            }
        }
}

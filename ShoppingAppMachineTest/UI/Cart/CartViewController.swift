//
//  CartViewController.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartItems: [Item] = []
    
    @IBOutlet weak var cartTableView: UITableView! {
        didSet {
            cartTableView.delegate = self
            cartTableView.dataSource = self
            self.cartTableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "CartTableViewCell")
        }
    }
    
    @IBOutlet weak var checkoutTotalbackroundView: UIView! {
        didSet {
            checkoutTotalbackroundView.addCornerRadius(radius: 10)
        }
    }
    
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var checkoutBtn: UIButton! {
        didSet {
            checkoutBtn.addCornerRadius(radius: 10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cart"
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
        cell.quantityUpdateClosure = { [weak self] item, quantity in
            self?.updateLabels(item: item, quantity: quantity)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateLabels(item: Item, quantity: Int) {
        var subtotal: Int = 0

        for cartItem in cartItems {
            
            subtotal += Int(cartItem.price) * quantity
        }

        let discount = subtotal % 100
        let total = subtotal - discount

        subTotalLbl.text = "₹\(subtotal)"
        discountLbl.text = "₹\(discount)"
        totalLabel.text = "₹\(total)"
    }
}

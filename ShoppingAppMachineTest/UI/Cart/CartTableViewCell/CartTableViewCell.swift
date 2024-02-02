//
//  CartTableViewCell.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 02/02/24.
//
import UIKit
import UIKit

class CartTableViewCell: UITableViewCell {

    // MARK: -Variable Declaration
    var item: Item!
    var quantityUpdateClosure: ((Item, Int) -> Void)?

    var quantity: Int = 0 {
        didSet {
            quantityLbl.text = "\(quantity)"
            updatetotalPriceLabels()
        }
    }
    
    // MARK: -IBOutlet
    @IBOutlet weak var cartImgIcon: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var eachItemPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var cartCellBackround: UIView! {
        didSet {
            cartCellBackround.addCornerRadius(radius: 10)
            cartCellBackround.addShadowToView(left: -5, bottom: 5, color: .black, opacity: 0.5, shadowRadius: 5)
        }
    }

  // MARK: -IBAction

    @IBAction func removeQuantityPressed(_ sender: UIButton) {
        if quantity > 0 {
            quantity -= 1
            quantityUpdateClosure?(item!, quantity)
        }
    }

    @IBAction func addQuantityPressed(_ sender: UIButton) {
        quantity += 1
        quantityUpdateClosure?(item!, quantity)
    }
    
    
    
   // MARK: -LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        quantityLbl.text = "\(quantity)"
    }

    
    // MARK: -Methods
    
    
    func configure(with item: Item) {
        self.item = item
        itemNameLbl.text = item.name
        eachItemPriceLabel.text = "₹\(item.price)"
        totalPriceLbl.text = "₹\(Int(item.price) * quantity)"
        cartImgIcon.downloadImage(from: item.icon)
    }

    func updatetotalPriceLabels() {
        guard let item = item else { return }
        totalPriceLbl.text = "₹\(Int(item.price) * quantity)"
        quantityUpdateClosure?(item, quantity)
    }
}

//
//  CartTableViewCell.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 02/02/24.
//
import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    var item : Item?
    var priceUpdateClosure: (() -> Void)?

    
    @IBOutlet weak var cartImgIcon: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var eachitemPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var backroundView: UIView!
    
    
    var quantity: Int = 0 {
        didSet {
            quantityLbl.text = "\(quantity)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backroundView.layer.cornerRadius = 10
        backroundView.layer.masksToBounds = true
        quantityLbl.text = "\(quantity)"
        backroundView.addShadowToView(left: -5, bottom: 5, color: .black, opacity: 0.5, shadowRadius: 5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with item: Item) {
        itemNameLbl.text = item.name
        eachitemPriceLabel.text = "₹\(item.price)"
        
        self.item = item
        totalPriceLbl.text = "₹\(Int(item.price))"
        cartImgIcon.downloadImage(from: item.icon)
        
    }
    
    @IBAction func removeQuantityPressed(_ sender: UIButton) {
        
        if quantity > 0 {
            quantity -= 1
        }
        updatetotalPriceLabels()
    }
    
    @IBAction func addQuantityPressed(_ sender: UIButton) {
        quantity += 1
        updatetotalPriceLabels()
    }
    
    func updatetotalPriceLabels(){
        totalPriceLbl.text = "₹\(Int(item?.price ?? 1) * quantity )"
        priceUpdateClosure?()
        
    }
    
}

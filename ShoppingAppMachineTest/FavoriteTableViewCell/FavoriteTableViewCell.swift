//
//  FavoriteTableViewCell.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    var addedToFavoriteClosure: (() -> Void)?

    
    @IBOutlet weak var itemImgIcon: UIImageView!
    
    @IBOutlet weak var itemNameLbl: UILabel!
   
    @IBOutlet weak var noofUnitLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addtoCartButton: UIButton!
    
    
    @IBOutlet weak var backroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backroundView.layer.cornerRadius = 10
        backroundView.layer.masksToBounds = true
        backroundView.addShadowToView(left: -5, bottom: 5, color: .black, opacity: 0.5, shadowRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

    func configure(with item: Item) {
        itemNameLbl.text = item.name
        priceLabel.text = "₹\(Int(item.price))"
        itemImgIcon.downloadImage(from: item.icon)
        
    }
   
    
}

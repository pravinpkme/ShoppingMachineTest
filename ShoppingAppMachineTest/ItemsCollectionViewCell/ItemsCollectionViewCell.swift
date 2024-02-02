//
//  ItemsCollectionViewCell.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//
import UIKit
import Foundation

class ItemsCollectionViewCell: UICollectionViewCell {

    var isFavorite : Bool = false
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageofItems: UIImageView!
    @IBOutlet weak var nameOfitem: UILabel!
    @IBOutlet weak var priceofItem: UILabel!
    @IBOutlet weak var addtoCartImg: UIImageView!
    @IBOutlet weak var CellbackgroundView: UIView!

    private var item: Item?
    
    var addToCartClosure: (() -> Void)?
    var addToFavClosure: ((Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        CellbackgroundView.layer.cornerRadius = 10
        CellbackgroundView.layer.masksToBounds = true
        CellbackgroundView.addShadowToView(left: -5, bottom: 5, color: .black, opacity: 0.5, shadowRadius: 5)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToCartTapped))
        addtoCartImg.isUserInteractionEnabled = true
        addtoCartImg.addGestureRecognizer(tapGestureRecognizer)
    }

    func configure(with item: Item) {
        self.item = item
        nameOfitem.text = item.name
        priceofItem.text = "\(item.price)"
        let imageURL = item.icon
        imageofItems.downloadImage(from: imageURL)
    }
    
    // MARK: -Add to cart Tapped
    @objc private func addToCartTapped() {
        if item != nil {
            addToCartClosure?()
        }
    }
    
    @IBAction func addToFavTapped(_ sender: UIButton) {
        if item != nil {
                isFavorite.toggle()
                if isFavorite {
                    favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    favoriteButton.tintColor = .red
                    addToFavClosure?(true)
                } else {
                    favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    favoriteButton.tintColor = .gray
                   addToFavClosure?(false)
                }
        }
    }

    
    
}

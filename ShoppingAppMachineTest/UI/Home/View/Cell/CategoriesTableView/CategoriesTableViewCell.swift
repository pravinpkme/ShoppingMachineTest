//
//  CategoriesTableViewCell.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    var itemsData: ItemsModel?
    var addToCartClosure: ((Item) -> Void)?
    var addTOFavClosure: ((Item, Bool) -> Void)?

    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var showMoreimg: UIImageView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var categoryBackroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemsCollectionView.register(UINib(nibName: "ItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsCollectionViewCell")
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        categoryBackroundView.addBottomLine()
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: 180, height: 220)
        flowlayout.minimumInteritemSpacing = 10
        flowlayout.minimumLineSpacing = 10
        flowlayout.scrollDirection = .horizontal
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)

        itemsCollectionView.collectionViewLayout = flowlayout
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCells(indexPath: IndexPath) {
        if let category = itemsData?.categories[indexPath.row] {
            categoriesLabel.text = category.name
        } else {
            categoriesLabel.text = "N/A"
        }
    }
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = itemsData?.categories[collectionView.tag], let items = category.items {
            return items.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionViewCell", for: indexPath) as! ItemsCollectionViewCell

        cell.addToCartClosure = { [weak self] in
            guard let self = self, let category = self.itemsData?.categories[collectionView.tag], let items = category.items, indexPath.item < items.count else {
                return
            }
            let item = items[indexPath.item]
            self.addToCartClosure?(item)
        }
        
        cell.addToFavClosure = { [weak self] canAddorRemove in
            guard let self = self, let category = self.itemsData?.categories[collectionView.tag], let items = category.items, indexPath.item < items.count else {
                return
            }
            let item = items[indexPath.item]
            self.addTOFavClosure?(item, canAddorRemove)
        }


        if let category = itemsData?.categories[collectionView.tag], let items = category.items, indexPath.item < items.count {
            let item = items[indexPath.item]
            cell.configure(with: item)
        }

        return cell
    }
    
   
}

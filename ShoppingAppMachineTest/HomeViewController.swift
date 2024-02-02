//
//  ViewController.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import UIKit


class HomeViewController: UIViewController {
   
    var cartItems: [Item] = []
    var favItems : [Item] = []
    var itemsData: ItemsModel?
    var viewModel = ShoppingViewModel()
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    

    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var HomeCategoriesTableView: UITableView!
    
    @IBOutlet weak var categoriesBackgroundView: UIView!

    @IBOutlet weak var favoritesBtn: UIButton!
    
    
    @IBOutlet weak var cartBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.itemsData = self?.viewModel.shoppingModel
                    self?.HomeCategoriesTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        
        categoriesBackgroundView.layer.cornerRadius = 10
        categoriesBackgroundView.layer.masksToBounds = true
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(categoriesBackgroundTapped))
        categoriesBackgroundView.isUserInteractionEnabled = true
        categoriesBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        
        HomeCategoriesTableView.delegate = self
        HomeCategoriesTableView.dataSource = self

        self.HomeCategoriesTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
    }
    
    
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.cartItems = cartItems
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func favoriteBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        vc.favItems = favItems
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    @objc private func categoriesBackgroundTapped() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsData?.categories.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as! CategoriesTableViewCell

        cell.itemsData = itemsData
        cell.setupCells(indexPath: indexPath)
        cell.itemsCollectionView.tag = indexPath.row
        cell.addToCartClosure = { [weak self] item in
            self?.addToCart(item: item)
            
        }
        cell.addTOFavClosure = { [weak self] item, canAddorRemove in
            self?.addToFavorites(item: item, canAddorRemove: canAddorRemove)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
extension HomeViewController {
    func addToCart(item: Item) {
        if !cartItems.contains(where: { existingItem in
            return existingItem.id == item.id
        }) {
            cartItems.append(item)
        }
    }
    
    func addToFavorites(item: Item, canAddorRemove: Bool){
        if canAddorRemove{
            if !favItems.contains(where: { existingItem in
                return existingItem.id == item.id
            }) {
                print("added")
                favItems.append(item)
            }
        }else{
            favItems.removeAll { existingItem in
             return existingItem.id == item.id
            }
        }
    }

}

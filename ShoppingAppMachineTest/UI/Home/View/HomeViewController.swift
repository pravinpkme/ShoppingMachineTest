//
//  ViewController.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import UIKit


class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var itemsData: ItemsModel?
    var viewModel = HomeViewModel()
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    // MARK: -IBOutlet
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var HomeCategoriesTableView: UITableView!{
        didSet{
            HomeCategoriesTableView.delegate = self
            HomeCategoriesTableView.dataSource = self
            
            self.HomeCategoriesTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoriesTableViewCell")
        }
    }
    @IBOutlet weak var categoriesBackgroundView: UIView!{
        didSet{
            categoriesBackgroundView.addCornerRadius(radius: 10)
            
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(categoriesBackgroundTapped))
            categoriesBackgroundView.isUserInteractionEnabled = true
            categoriesBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @IBOutlet weak var favoritesBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    
    
    // MARK: -IBAction
    @IBAction func cartButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        vc.cartItems = viewModel.cartItems
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func favoriteBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        vc.favItems = viewModel.favItems
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc private func categoriesBackgroundTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataTotableView()
    }
    
    
    func loadDataTotableView(){
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
            self?.viewModel.addToCart(item: item)
        }
        cell.addTOFavClosure = { [weak self] item, canAddorRemove in
            self?.viewModel.addToFavorites(item: item, canAddorRemove: canAddorRemove)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
    
}

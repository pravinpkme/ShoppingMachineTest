//
//  FavoritesViewController.swift
//  ShoppingAppTest
//
//  Created by Pravin Kumar on 01/02/24.
//

import Foundation
import UIKit
class FavoritesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var favItems: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorites"
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        self.favoritesTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let favItem = favItems[indexPath.row]
        cell.configure(with: favItem)
        cell.addedToFavoriteClosure = { [weak self] in
            
            self?.updateLabels()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func updateLabels(){
        
    }
    
    
}

//
//  UIImage+Extension.swift
//  ShoppingAppMachineTest
//
//  Created by Pravin Kumar on 02/02/24.
//

import Foundation
import UIKit

// MARK: -Network Request to Download Image and load
extension UIImageView {
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
                
            }
        }.resume()
    }
}

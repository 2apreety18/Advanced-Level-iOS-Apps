//
//  CategoryCell.swift
//  coder-swag
//
//  Created by preety on 14/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    func updateViews(category: Category){
        //passing image and title to the view
        categoryImage.image = UIImage(named: category.imageName)
        categoryTitle.text = category.title
    }

    

}

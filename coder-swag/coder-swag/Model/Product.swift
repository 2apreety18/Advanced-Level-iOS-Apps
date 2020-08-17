//
//  Product.swift
//  coder-swag
//
//  Created by preety on 17/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

struct Product{
    private(set) public var title: String
    private(set) public var price: String
    private(set) public var imageName: String

    
    //passing data from DataService to own variables after collecting them
    init(title: String,price: String, imageName: String) {
        self.title = title
        self.price = price
        self.imageName = imageName
    }
}

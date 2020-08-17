//
//  Category.swift
//  coder-swag
//
//  Created by preety on 14/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

struct Category {
    private(set) public var title: String
    private(set) public var imageName: String
    
    //passing data to App own variables after collecting them
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

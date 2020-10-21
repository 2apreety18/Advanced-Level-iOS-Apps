//
//  Article.swift
//  GoodNews
//
//  Created by preety on 20/10/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles : [Article] //var name must be same as API's
}


struct Article: Decodable {
    let title: String
    let description: String
}

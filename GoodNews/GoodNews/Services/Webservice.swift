//
//  Webservice.swift
//  GoodNews
//
//  Created by preety on 20/10/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import Foundation

class Websevice {
    
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
            }
            
        }.resume()
    }
}

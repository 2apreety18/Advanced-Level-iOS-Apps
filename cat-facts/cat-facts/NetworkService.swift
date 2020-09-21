//
//  NetworkService.swift
//  cat-facts
//
//  Created by preety on 21/9/20.
//  Copyright © 2020 Preety. All rights reserved.
//
import UIKit
import Foundation

class NetworkService {
    
    static let instance = NetworkService()
    private init(){}
    
    let factBaseUrl = "https://cat-fact.herokuapp.com"
    let imageBaseUrl = "https://api.thecatapi.com"


    func makeFactRequest(completion: @escaping (String) -> ()){ //completion handler
        
        let randomFactEndpoint = URL(string: factBaseUrl + "/facts/random")
        guard let url = randomFactEndpoint else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //1st, check to make sure there were no errors
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            //2nd, check that response is of current type & the request was successful
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                debugPrint("Server error")
                return
            }
            
            //3rd, making sure we definitely have data
            guard let data = data else {return}
             //print(data)
            
            //finally, parse JSON data and cast it as a dictionary so we can pull out the fact text to display
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else { return }
                let fact = json["text"] as? String ?? ""
                
                DispatchQueue.main.async {
                    completion(fact)
                }
                
            }catch{
                debugPrint("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func downloadCatImage(completion: @escaping (UIImage) -> ()) {
        //get image url
        getCatImageUrl { (imageUrl) in
            self.downloadImage(url: imageUrl) { (image) in
                completion(image)
            }
        }
        //use image url to download the image
    }
    
    
    func getCatImageUrl(completion: @escaping (String) -> ()){
           
           let imageEndpoint = URL(string: imageBaseUrl + "/v1/images/search")
           guard let url = imageEndpoint else { return }
           
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               
               //1st, check to make sure there were no errors
               if let error = error {
                   debugPrint(error.localizedDescription)
                   return
               }
               
               //2nd, check that response is of current type & the request was successful
               guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                   debugPrint("Server error")
                   return
               }
               
               //3rd, making sure we definitely have data
               guard let data = data else {return}
               
               //finally, parse JSON data and cast it as a dictionary so we can pull out the fact text to display
               do {
                   guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [[String: Any]] else { return }
                   let imageUrl = json[0]["url"] as? String ?? ""
                   completion(imageUrl)
                
               }catch{
                   debugPrint("JSON error: \(error.localizedDescription)")
               }
           }
           task.resume()
       }
       
       
       
    func downloadImage(url: String, completion: @escaping (UIImage) -> ()){
           
           guard let url = URL(string: url) else { return }
           
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
               
               //1st, check to make sure there were no errors
               if let error = error {
                   debugPrint(error.localizedDescription)
                   return
               }
               
               //2nd, check that response is of current type & the request was successful
               guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                   debugPrint("Server error")
                   return
               }
               
               //3rd, making sure we definitely have data
               guard let data = data else {return}
               
               guard let image = UIImage(data: data) else { return }
               
               DispatchQueue.main.async {
                   completion(image)
               }
               
           }
           task.resume()
       }
}

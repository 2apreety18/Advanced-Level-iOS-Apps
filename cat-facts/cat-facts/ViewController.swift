//
//  ViewController.swift
//  cat-facts
//
//  Created by preety on 21/9/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catFactLbl: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getCatfact(_ sender: Any) {
        NetworkService.instance.makeFactRequest {[weak self] (fact) in
            guard let self = self else { return }
            self.catFactLbl.text = fact
        }
        
        NetworkService.instance.downloadCatImage {[weak self] (image) in
            guard let self = self else { return }
            self.catImageView.image = image
        }
    }
    
    
    
   
}


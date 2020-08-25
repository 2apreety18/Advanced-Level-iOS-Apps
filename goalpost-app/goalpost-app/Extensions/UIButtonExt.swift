//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by preety on 21/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

extension UIButton{
    func setSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    func setDeselectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.6689028715, green: 0.9334742437, blue: 0.6823682598, alpha: 1)
    }
}

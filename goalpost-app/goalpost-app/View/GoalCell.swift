//
//  GoalCell.swift
//  goalpost-app
//
//  Created by preety on 19/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    //the design that will be shown in the cell using User input
    func configureCell(goal: Goal){
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType //to get the String value from another CLASS file, use .rawValue
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        
        if goal.goalProgress == goal.goalCompletionValue{
            self.completionView.isHidden = false
        }else{
            self.completionView.isHidden = true
        }
    }

}

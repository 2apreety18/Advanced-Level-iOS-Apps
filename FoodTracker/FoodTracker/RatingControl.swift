//
//  RatingControl.swift
//  FoodTracker
//
//  Created by preety on 30/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit

//Interface Builder does not know anything about the contents of your rating control add @IBDesignable
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
                updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
     
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    

    //MARK: Initialization
    
    override init(frame: CGRect) {
        //Add this line to call the superclass’s initializer:
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    
    private func setupButtons(){
        
        //First, it removes the button from the list of views managed by the stack view. This tells the stack view that it should no longer calculate the button’s size and position—but the button is still a subview of the stack view. Next, the code removes the button from the stack view entirely. Finally, once all the buttons have been removed, it clears the ratingButtons array.
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
      
      
      // Load Button Images
      let bundle = Bundle(for: type(of: self))
      let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
      let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
      let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
      for index in 0..<starCount {
        
        let button = UIButton()
        
        // Set the button images
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        // Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false //translatesAutoresizingMaskIntoConstraints property defaults to true.Making it false disables the button’s automatically generated constraints.
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        /* 1.  You use layout anchors to create constraints—in this case, constraints that define the view’s height and width, respectively.

         2. The anchor’s constraint(equalToConstant:) method returns a constraint that defines a constant height or width for the view.

         3.  The constraint’s isActive property activates or deactivates the constraint. When you set this property to true, the system adds the constraint to the correct view, and activates it. */
        
        // Set the accessibility label
        button.accessibilityLabel = "Set \(index + 1) star rating"
        
        // Setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside) //you used the target-action pattern to link elements in your storyboard to action methods in your code. The addTarget(_, action:, for:) method does the same thing in code.
        
        // Add the button to the stack
        addArrangedSubview(button)
        // Add the new button to the rating button array
        ratingButtons.append(button)
        
        
      }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        //the firstindexOf(_:) method attempts to find the selected button in the array of buttons and to return the index at which it was found.Once you have the button’s index (in this case a value from 0 to 4), you add 1 to the index to calculate the selected rating (giving you a value from 1 to 5). If the user tapped the star that corresponds with the current rating, you reset the control’s rating property to 0. Otherwise, you set the rating to the selected rating.
        
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        
        //This code iterates through the buttons and sets each one’s selected state based on its position and the rating.
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
            
           /* Here, you start by checking whether the button is the currently selected button. If it is, you assign a hint. If not, you set the button’s hintString property to nil.

            Next, you calculate the value based on the control’s rating. Use a switch statement to assign custom strings if the rating is 0 or 1. If the rating is greater than 1, you calculate the hint using string interpolation. */

            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
             
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
             
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
    
}

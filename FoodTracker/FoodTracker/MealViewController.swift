//
//  ViewController.swift
//  FoodTracker
//
//  Created by preety on 30/8/20.
//  Copyright © 2020 Preety. All rights reserved.
//

import UIKit
import os.log

//ViewController needs to adopt the UIImagePickerControllerDelegate protocol. Because ViewController will be in charge of presenting the image picker controller, it also needs to adopt the UINavigationControllerDelegate protocol, which simply lets ViewController take on some basic navigation responsibilities.
class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //set the ViewController object as the delegate of its nameTextField property
        //The self refers to the ViewController class, because it’s referenced inside the scope of the ViewController class definition.
        //When a ViewController instance is loaded, it sets itself as the delegate of its nameTextField property.
        nameTextField.delegate = self
        // Set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text   = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }

   
    
   /* When the user taps a text field, it automatically becomes the first responder.As a result of the text field becoming the first responder, iOS displays the keyboard and begins an editing session for that text field.
      When a user wants to finish editing the text field, the text field needs to resign its first-responder status. Because the text field will no longer be the active object in the app, events need to get routed to a more appropriate object.This is where your implementation of UITextFieldDelegate methods comes in.
      You need to specify that the text field should resign its first-responder status when the user taps a button to end editing in the text field.
     */

    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // resign the text field’s first-responder status & hide the keyboard
        textField.resignFirstResponder()
        return true //This method returns a Boolean value that indicates whether the system should process the press of the Return key. In this case, it's true as want to response the user press of the return key
    }
    
    //textFieldDidEndEditing(_:), is called after the text field resigns its first-responder status.
    //Because you resign first responder status in textFieldShouldReturn, the system calls this method just after calling textFieldShouldReturn.
    func textFieldDidEndEditing(_ textField: UITextField) {
        //The textFieldDidEndEditing(_:) method gives you a chance to read the information entered into the text field and do something with it.
        //mealNameLabel.text = textField.text
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    
    
//Mark: UIImagePickerControllerDelegate
    
    
    //just as you need a text field delegate when you work with a text field, you need an image picker controller delegate to work with an image picker controller. The name of that delegate protocol is UIImagePickerControllerDelegate
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //This code ensures that if the user taps the image view while typing in the text field, the keyboard is dismissed properly.
        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        // The method asks ViewController to present the view controller defined by imagePickerController. Passing true to the animated parameter animates the presentation of the image picker controller. The completion parameter refers to a completion handler, a piece of code that executes after this method completes. Because you don’t need to do anything else, you indicate that you don’t need to execute a completion handler by passing in nil.
        present(imagePickerController,animated: true, completion: nil)
    }
    
    //imagePickerControllerDidCancel(_:), gets called when a user taps the image picker’s Cancel button.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    //imagePickerController(_:didFinishPickingMediaWithInfo:), gets called when a user selects a photo. This method gives you a chance to do something with the image or images that a user selected from the picker. In your case, you’ll take the selected image and display it in your image view.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original not the edited one
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the image picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}


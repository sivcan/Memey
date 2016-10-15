//
//  ViewController.swift
//  MeMey
//
//  Created by Sivcan Singh on 15/10/16.
//  Copyright © 2016 Sivcan Singh. All rights reserved.
//

import UIKit
@IBDesignable
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var blurBg: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraSelect: UIBarButtonItem!
    
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var topField: UITextField!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.white,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : CGFloat(5),
    ] as [String : Any]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleFields(x: true)
        
        topField.defaultTextAttributes = memeTextAttributes
        bottomField.defaultTextAttributes = memeTextAttributes
        
        subscribeToKeyboardNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        blurBg.isHidden = true
        cameraSelect.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topField.textAlignment =  NSTextAlignment.center
        bottomField.textAlignment = NSTextAlignment.center
        
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func toggleFields(x: Bool) {
        topField.isHidden = x
        bottomField.isHidden = x
    }
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    
    @IBAction func imageSelector(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if(sender.tag == 0) {
            imagePicker.sourceType = .photoLibrary
        }
        else {
            imagePicker.sourceType = .camera
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            toggleFields(x: false)  //Not working.! 
            imageView.image = image
            blurBg.isHidden = false
            blurBg.alpha = CGFloat(0.7)
            UIView.animate(withDuration: 0.5, animations: {
                self.blurBg.effect = UIBlurEffect(style: .light)
            }, completion: nil)
            headLabel.isHidden = true
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


//
//  ViewController.swift
//  MeMey
//
//  Created by Sivcan Singh on 15/10/16.
//  Copyright © 2016 Sivcan Singh. All rights reserved.
//

import UIKit
@IBDesignable
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        NSTextAlignment : center
    ] as [String : Any]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //toggleFields(x: true)
        topField.defaultTextAttributes = memeTextAttributes
        bottomField.defaultTextAttributes = memeTextAttributes
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        blurBg.isHidden = true
        cameraSelect.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func toggleFields(x: Bool) {
        topField.isHidden = x
        bottomField.isHidden = x
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
            
            imageView.image = image
            blurBg.isHidden = false
            blurBg.alpha = CGFloat(0.7)
            UIView.animate(withDuration: 0.5, animations: {
                self.blurBg.effect = UIBlurEffect(style: .light)
            }, completion: nil)
            headLabel.isHidden = true
            
            toggleFields(x: false)
        
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}


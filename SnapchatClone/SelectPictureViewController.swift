//
//  SelectPictureViewController.swift
//  SnapchatClone
//
//  Created by Admin on 24.07.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import AlertBar

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var message: UITextField!
    
    var imagePicker : UIImagePickerController = UIImagePickerController()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func selectPicTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgView.image = img
            imageSelected = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        guard imageSelected else {return AlertBar.show(type: .error, message: "Select an image for your snap", duration: 20)}
        guard message.text != "" else {return AlertBar.show(type: .error, message: "Enter a message for your snap", duration: 20)}
    }
}

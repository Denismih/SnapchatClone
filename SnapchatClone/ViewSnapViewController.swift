//
//  ViewSnapViewController.swift
//  SnapchatClone
//
//  Created by Admin on 01.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {

    var dataSnap : DataSnapshot?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let snap = dataSnap?.value as?NSDictionary else {return}
        guard let message = snap["message"] as? String else {return}
        guard let downloadURL = snap["imageURL"] as? String else {return}
        guard let url = URL(string: downloadURL) else {return}
        messageLabel.text = message
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "download"))

    }

    override func viewWillDisappear(_ animated: Bool) {
        guard let curUserID = Auth.auth().currentUser?.uid else {return}
        guard let key = dataSnap?.key else {return}
        guard let snap = dataSnap?.value as? NSDictionary else {return}
        guard let imageName = snap["imageName"] else {return}
        
        print (imageName)
        Database.database().reference().child("users").child(curUserID).child("snaps").child(key).removeValue()
        Storage.storage().reference().child(imageName as! String).delete { (error) in
            if error != nil {
                print (error?.localizedDescription as Any)
            }
        }
    }
}

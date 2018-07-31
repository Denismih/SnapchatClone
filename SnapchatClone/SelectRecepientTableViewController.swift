//
//  SelectRecepientTableViewController.swift
//  SnapchatClone
//
//  Created by Admin on 27.07.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectRecepientTableViewController: UITableViewController {

    var dowloadURL = ""
    var message = ""
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            if let userDict = snapshot.value as? NSDictionary {
                if let email = userDict["email"] as? String {
                    let user = User()
                    user.email = email
                    user.uid = snapshot.key
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            }
        }
               
    }

    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email

        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fromEmail = Auth.auth().currentUser?.email else {return}
        let user = users[indexPath.row]
        let snap = ["from":fromEmail, "message":message, "imageURL":dowloadURL]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
class User {
    var email = ""
    var uid = ""
}

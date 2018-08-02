//
//  SnapsTableViewController.swift
//  SnapchatClone
//
//  Created by Admin on 24.07.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {
    
    var snaps : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let curUserID = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(curUserID).child("snaps").observe(.childAdded) { (snapshot) in
            self.snaps.append(snapshot)
            self.tableView.reloadData()
        }
        Database.database().reference().child("users").child(curUserID).child("snaps").observe(.childRemoved) { (snapshot) in
            var i = 0
            for snap in self.snaps {
                if snap.key == snapshot.key {
                    self.snaps.remove(at: i)
                }
                i += 1
            }
            self.tableView.reloadData()
        }
        
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        try?  Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps yet 😜"
        } else {
            let snap = snaps[indexPath.row]
            if let snapDict = snap.value as? NSDictionary {
                if let fromEmail = snapDict["from"] as? String {
                    cell.textLabel?.text = fromEmail
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnap", sender: snap)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnap" {
            if let viewVS = segue.destination as? ViewSnapViewController {
                if let snap = sender as? DataSnapshot {
                    viewVS.dataSnap = snap
                }
            }
        }
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

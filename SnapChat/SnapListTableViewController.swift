//
//  SnapListTableViewController.swift
//  SnapChat
//
//  Created by Xiaohao Li on 2017/5/16.
//  Copyright © 2017年 Xiaohao Li. All rights reserved.
//

import UIKit
import Firebase

class SnapListTableViewController: UITableViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddSnap))
        
    }
    
    func handleLogout() {
        
        
        do {
            try FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
            
            
        } catch let signOutError {
            print("Failed to sign out:", signOutError)
        }
        
        
        
        
    }
    
    func handleAddSnap() {
        navigationController?.pushViewController(AddSnapViewController(), animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    

}

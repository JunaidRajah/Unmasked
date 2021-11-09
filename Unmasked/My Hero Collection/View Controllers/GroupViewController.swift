//
//  GroupViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/09.
//

import UIKit

class GroupViewController: UIViewController {
    
    var selectedGroup = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupsToList" {
            super.prepare(for: segue, sender: sender)
            let destination = segue.destination as! HeroCollectionViewController
            destination.heroGroup = selectedGroup
        }
    }
    
    @IBAction func heroGroupSelected(_ sender: UIButton) {
        selectedGroup = sender.tag
        performSegue(withIdentifier: "groupsToList", sender: self)
    }
}

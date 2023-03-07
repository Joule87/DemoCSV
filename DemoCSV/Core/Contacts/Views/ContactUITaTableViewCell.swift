//
//  ContactUITaTableViewCell.swift
//  DemoCSV
//
//  Created by Julio Collado Perez on 3/5/23.
//

import UIKit

class ContactUITaTableViewCell: UITableViewCell {
    
    static let identifier = "ContactUITaTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    func set(name: String, email: String, phoneNumber: String) {
        nameLabel.text = name
        emailLabel.text = email
        phoneLabel.text = phoneNumber
    }
    
}

//
//  CorporateProfileTableViewCell.swift
//  LoadUnload
//
//  Created by Admin on 10/01/17.
//  Copyright © 2017 FreeLancer. All rights reserved.
//

import UIKit

class CorporateProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

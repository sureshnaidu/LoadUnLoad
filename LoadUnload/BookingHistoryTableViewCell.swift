//
//  BookingHistoryTableViewCell.swift
//  LoadUnload
//
//  Created by Admin on 09/01/17.
//  Copyright © 2017 FreeLancer. All rights reserved.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {

    @IBOutlet var confirmTitleLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var bookingIdLabel: UILabel!
    @IBOutlet var fromAdderessLAbel: UILabel!
    @IBOutlet var toAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

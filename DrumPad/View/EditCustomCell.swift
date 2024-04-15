//
//  EditCustomCell.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 25.01.24.
//

import UIKit

class EditCustomCell: UITableViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var musicLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

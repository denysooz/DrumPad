//
//  EditCell.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 25.01.24.
//

import UIKit

class EditCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

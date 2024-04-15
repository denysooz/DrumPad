//
//  MusicCell.swift
//  DrumPad
//
//  Created by Denis Dareuskiy on 25.01.24.
//

import UIKit

class MusicCell: UITableViewCell {
    
    @IBOutlet var musicLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        musicLabel.font = UIFont.systemFont(ofSize: 15)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ToDoTableViewCell.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 22/03/23.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var statusLabel:UILabel!
    @IBOutlet var userIDLabel:UILabel!
    @IBOutlet var idLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

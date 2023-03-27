//
//  CreateUserTableViewCell.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 22/03/23.
//

import UIKit

class CreateUserTableViewCell: UITableViewCell {
    @IBOutlet var idLabel:UILabel!
    @IBOutlet var userIdLabel:UILabel!
    @IBOutlet var bodyLabel:UILabel!
    @IBOutlet var titleLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

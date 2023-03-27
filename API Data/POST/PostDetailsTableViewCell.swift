//
//  PostDetailsTableViewCell.swift
//  API Data
//
//  Created by Soujanya Mandadapu on 21/03/23.
//

import UIKit

class PostDetailsTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var ageLabel:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

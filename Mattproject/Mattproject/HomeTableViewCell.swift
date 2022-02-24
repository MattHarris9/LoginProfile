//
//  HomeTableViewCell.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/11/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var customImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

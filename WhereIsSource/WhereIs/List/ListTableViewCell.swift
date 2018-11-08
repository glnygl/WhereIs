//
//  ListTableViewCell.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeLocationLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

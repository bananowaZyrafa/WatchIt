//
//  PropositionTableViewCell.swift
//  WatchIt
//
//  Created by Paweł W. on 07/02/17.
//  Copyright © 2017 Bart. All rights reserved.
//

import UIKit

class PropositionTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var positionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
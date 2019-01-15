//
//  ExerciseTableViewCell.swift
//  6 Pack ABs
//
//  Created by Raymond Chau on 1/9/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import UIKit
import AVKit

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func prepareForReuse() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

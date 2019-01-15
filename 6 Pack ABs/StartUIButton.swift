//
//  StartUIButton.swift
//  6 Pack ABs
//
//  Created by Raymond Chau on 1/12/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import UIKit

@IBDesignable
class StartUIButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}

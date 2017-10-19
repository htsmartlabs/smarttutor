//
//  BorderButton.swift
//  SmartTutor
//
//  Created by Tapas Mandal on 2017-10-19.
//  Copyright © 2017 htsmartlabs. All rights reserved.
//

import UIKit

@IBDesignable
class BorderButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeview()
    }
    override func prepareForInterfaceBuilder() {
        customizeview()
    }
    
    func customizeview(){
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }
}

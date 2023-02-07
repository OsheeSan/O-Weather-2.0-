//
//  SmallButton.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import UIKit

@IBDesignable
class SmallButton: UIButton {

    override func prepareForInterfaceBuilder() {
        configure()
    }
    
    override func awakeFromNib() {
        configure()
    }
    
    func configure(){
        clipsToBounds = true
        layer.cornerRadius = frame.width/2
        backgroundColor = .black
    }
}

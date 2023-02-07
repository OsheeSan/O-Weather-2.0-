//
//  SearchView.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import UIKit

@IBDesignable
class SearchView: UIView {

    override func prepareForInterfaceBuilder() {
        configure()
    }
    
    override func awakeFromNib() {
        configure()
    }

    func configure(){
        clipsToBounds = true
        layer.cornerRadius = 15
        backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
}

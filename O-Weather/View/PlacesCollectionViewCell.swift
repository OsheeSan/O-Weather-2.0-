//
//  PlacesCollectionViewCell.swift
//  O-Weather
//
//  Created by admin on 06.02.2023.
//

import UIKit

@IBDesignable
class PlacesCollectionViewCell: UICollectionViewCell {
    
    override func prepareForInterfaceBuilder() {
          setupView()
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

      func setupView() {
          self.backgroundColor = color
          self.layer.cornerRadius = cornerRadius
          self.layer.shadowColor = shadowColor.cgColor
          self.layer.shadowRadius = shadowRadius
          self.layer.shadowOpacity = shadowOpacity
          self.layer.borderWidth = borderWidth
          self.layer.borderColor = borderColor.cgColor
      }
  
//  // MARK: - Initialization
//  override init(frame: CGRect) {
//      super.init(frame: frame)
//  }
//
//  required init?(coder: NSCoder) {
//      super.init(coder: coder)
//  }

  // MARK: - Properties
  @IBInspectable var color: UIColor? {
      get {
          return super.backgroundColor
      }
      set {
          super.backgroundColor = newValue
      }
  }

    @IBInspectable var cornerRadius: CGFloat = 0 {
      didSet {
          self.layer.cornerRadius = cornerRadius
      }
  }

    @IBInspectable var shadowColor: UIColor = .black {
      didSet {
          self.layer.shadowColor = shadowColor.cgColor
      }
  }

    @IBInspectable var shadowRadius: CGFloat = 0 {
      didSet {
          self.layer.shadowRadius = shadowRadius
      }
  }

    @IBInspectable var shadowOpacity: Float = 0 {
      didSet {
          self.layer.shadowOpacity = shadowOpacity
      }
  }

    @IBInspectable var borderWidth: CGFloat = 0 {
      didSet {
          self.layer.borderWidth = borderWidth
      }
  }

    @IBInspectable var borderColor: UIColor = .white {
      didSet {
          self.layer.borderColor = borderColor.cgColor
      }
  }
}

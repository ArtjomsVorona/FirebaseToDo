//
//  DesignButton.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 08/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

@IBDesignable class DesignButton: BounceButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
      }
      
      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
      }
    
    func setupButton() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor  = borderColor.cgColor
    }
    
    @IBInspectable var cornerRadius: CGFloat = 16.0 {
        didSet {
            self.setupButton()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.setupButton()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .systemPurple {
        didSet {
            self.setupButton()
        }
    }

}

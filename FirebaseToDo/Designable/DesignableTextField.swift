//
//  DesignableTextField.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 08/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

@IBDesignable class DesignableTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
      }
    
    
    func setupTextField() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        //leftView of the textField
        self.leftViewMode = .always
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 24, height: 24))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 25
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: 24))
            view.addSubview(imageView)
            self.leftView = view
        } else {
            self.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: leftPadding, height: 2.0))
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 16.0 {
        didSet {
            self.setupTextField()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.setupTextField()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .systemPurple {
        didSet {
            self.setupTextField()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 10.0 {
        didSet{
            self.setupTextField()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            self.setupTextField()
        }
    }
    
}

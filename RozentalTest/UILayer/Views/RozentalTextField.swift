//
//  RozentalTextField.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 29.08.2024.
//

import UIKit

enum TextFieldStyle: String {
    case email = "at"
    case password = "lock"
}

class ExtendedHitButton: UIButton {
    var extendSize: CGFloat = 0
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if point.x >= -extendSize &&
            point.x <= bounds.width + extendSize &&
            point.y >= -extendSize &&
            point.y <= bounds.height + extendSize {
            return true
        }
        return false
    }
}

class RozentalTextField: UITextField {
    private let secureButton = ExtendedHitButton()
    
    var style: TextFieldStyle = .email {
        didSet {
            setupPlaceholderStyle(style: style)
        }
    }
    
    init(style: TextFieldStyle = .email) {
        super.init(frame: .zero)
        self.style = style
        
        setupTextField()
        setupSecureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSecureButton() {
        self.addSubview(secureButton)
        secureButton.extendSize = 30
        secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        secureButton.tintColor = AppColors.gray
        secureButton.addTarget(self, action: #selector(pressedSecureButton), for: .touchUpInside)
        secureButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secureButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            secureButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            secureButton.heightAnchor.constraint(equalToConstant: 20),
            secureButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupTextField() {
        self.layer.cornerRadius = 12
        self.backgroundColor = AppColors.white
        self.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        self.layer.borderWidth = 1
        self.font = .systemFont(ofSize: 18)
       
    }
    
    private func setupPlaceholderStyle(style: TextFieldStyle) {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.height))
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: -9, width: 20, height: 20.0))
        imageView.image = UIImage(systemName: style.rawValue)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray4
        leftPaddingView.addSubview(imageView)
        
        self.rightView = rightPaddingView
        self.leftView = leftPaddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
        
        switch style {
        case .email:
            self.placeholder = "E-mail"
            secureButton.isHidden = true
        case .password:
            self.placeholder = "Password"
            self.isSecureTextEntry = true
        }
    }
    
   @objc private func pressedSecureButton() {
       self.isSecureTextEntry.toggle()
       if self.isSecureTextEntry {
           secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
       } else {
           secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
       }
    }
}


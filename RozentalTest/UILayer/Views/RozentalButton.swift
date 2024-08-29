//
//  RozentalButton.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 28.08.2024.
//

import UIKit

enum ButtonColorSchemes {
    case white
    case orange
}

class RozentalButton: UIButton {
    private let button = UIButton()
    var action: (() -> Void)?
    var scheme: ButtonColorSchemes = .white {
        didSet {
            setColorScheme(scheme: scheme)
        }
    }
    
    init(scheme: ButtonColorSchemes = .white) {
        super.init(frame: .zero)
        self.scheme = scheme
        setupButtonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonUI() {
        self.backgroundColor = .clear
        setupButton()
    }
    
    func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    @objc private func buttonPressed() {
        guard let action = self.action else { return }
        action()
    }
    
    private func setColorScheme(scheme: ButtonColorSchemes) {
        switch scheme {
        case .white:
            button.backgroundColor = AppColors.white
            button.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
            button.layer.borderWidth = 1
            button.setTitleColor(AppColors.black, for: .normal)
        case .orange:
            button.backgroundColor = AppColors.buttonOrange
            button.setTitleColor(AppColors.black, for: .normal)
        }
    }
    
    public func setTitle(_ title: String?) {
        button.setTitle(title, for: .normal)
    }

}

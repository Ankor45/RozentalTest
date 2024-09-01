//
//  NotificationButton.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 30.08.2024.
//

import UIKit

class NotificationButton: UIButton {
    
    private let button = UIButton()
    private let redCircle = UILabel()
    private var count: Int = 0 {
        didSet {
            setCount(count: count)
        }
    }
    
    init(count: Int = 0) {
        super.init(frame: .zero)
        self.count = count
        setupButtonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonUI() {
        self.backgroundColor = .clear
        setupButton()
        setupCountView()
    }
    
    private func setupButton() {
        addSubview(button)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.configuration = .plain()
        button.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 25)
        button.tintColor = AppColors.white
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setupCountView() {
        addSubview(redCircle)
        redCircle.backgroundColor = AppColors.red
        redCircle.textAlignment = .center
        redCircle.font = .boldSystemFont(ofSize: 16)
        redCircle.textColor = AppColors.white
        redCircle.layer.cornerRadius = 11
        redCircle.adjustsFontSizeToFitWidth = true
        redCircle.clipsToBounds = true
        redCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            redCircle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            redCircle.topAnchor.constraint(equalTo: self.topAnchor, constant: -6),
            redCircle.widthAnchor.constraint(equalToConstant: 22),
            redCircle.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    func setCount(count: Int) {
        redCircle.text = "\(count)"
    }
    
}


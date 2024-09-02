//
//  SquareButton.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 01.09.2024.
//

import UIKit

enum SquareButtonType {
    case cam
    case barrier
    case proposal
}

class SquareButton: UIButton {
    private let pictureView = UIImageView()
    private let typeLabel = UILabel()
    private let button = UIButton()
    
    var action: (() -> Void)?
    var type: SquareButtonType = .cam {
        didSet {
            setSquareType(type: type)
        }
    }
    
    init(type: SquareButtonType = .cam) {
        super.init(frame: .zero)
        self.type = type
        setupButtonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonUI() {
        setupBackground()
        setupButton()
        setupPictureView()
        setupTypeLabel()
    }
    private func setupBackground() {
        backgroundColor = AppColors.lightGray
        layer.cornerRadius = 12
    }
    private func setupButton() {
        addSubview(button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    private func setupPictureView() {
        button.addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            pictureView.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -10)
        ])
    }
    private func setupTypeLabel() {
        button.addSubview(typeLabel)
        typeLabel.textColor = AppColors.black
        typeLabel.font = .boldSystemFont(ofSize: 16)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 10),
            typeLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
    }
    @objc private func buttonPressed() {
        guard let action = self.action else { return }
        action()
    }
    private func setSquareType(type: SquareButtonType) {
        switch type {
        case .cam:
            pictureView.image = UIImage(resource: .camIco)
            typeLabel.text = "Камеры"
        case .barrier:
            pictureView.image = UIImage(resource: .barrierIco)
            typeLabel.text = "Шлагбаум"
        case .proposal:
            pictureView.image = UIImage(resource: .lampIco)
            typeLabel.text = "Предложения"
        }
    }
}


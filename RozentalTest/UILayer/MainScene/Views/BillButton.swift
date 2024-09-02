//
//  BillButton.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 31.08.2024.
//

import UIKit

enum BillButtonStyle {
    case rent
    case utility
}

class BillButton: UIButton {
    
    private let pictureView = UIImageView()
    private let typeLabel = UILabel()
    private let dueDateLabel = UILabel()
    private let sumLabel = UILabel()
    private let button = UIButton()
    private let styleView = UIView()
    private let waterIco = UIButton()
    private let electricIco = UIButton()
    private let heatIco = UIButton()
    private let gasIco = UIButton()
    
    var action: (() -> Void)?
    var style: BillButtonStyle = .rent {
        didSet {
            setButtonStyle(style: style)
        }
    }
    
    init(style: BillButtonStyle = .rent) {
        super.init(frame: .zero)
        self.style = style
        setupButtonUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonUI() {
        self.backgroundColor = .clear
        setupButton()
        setupPictureView()
        setupTypeLabel()
        setupDueDateLabel()
        setupStyleView()
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
            pictureView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            pictureView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    private func setupTypeLabel() {
        button.addSubview(typeLabel)
        typeLabel.textColor = AppColors.black
        typeLabel.font = .boldSystemFont(ofSize: 18)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 6),
            typeLabel.topAnchor.constraint(equalTo: pictureView.topAnchor)
        ])
        
    }
    private func setupDueDateLabel() {
        button.addSubview(dueDateLabel)
        let date = "15 Апреля"
        dueDateLabel.text = "Оплатить до \(date)"
        dueDateLabel.textColor = AppColors.gray
        dueDateLabel.font = .boldSystemFont(ofSize: 16)
        dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dueDateLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 6),
            dueDateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor)
        ])
        
    }
    private func setupStyleView() {
        button.addSubview(styleView)
        styleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            styleView.topAnchor.constraint(equalTo: button.topAnchor),
            styleView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            styleView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            styleView.leadingAnchor.constraint(equalTo: dueDateLabel.trailingAnchor, constant: 20)
        ])
    }
    
    private func setupSumLabel() {
        styleView.addSubview(sumLabel)
        let sum = "5443.27 ₽"
        
        let attributedString = NSMutableAttributedString(string: sum)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.gray, range: NSRange(location: sum.count-5, length: 5 ))
        sumLabel.attributedText = attributedString
        sumLabel.font = .boldSystemFont(ofSize: 16)
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sumLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            sumLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
    }
    private func setupCountersView() {
        styleView.addSubview(waterIco)
        styleView.addSubview(electricIco)
        styleView.addSubview(heatIco)
        styleView.addSubview(gasIco)
        
        waterIco.setImage(UIImage(systemName: "drop.fill"), for: .normal)
        waterIco.tintColor = AppColors.black
        electricIco.setImage(UIImage(systemName: "bolt.fill"), for: .normal)
        electricIco.tintColor = AppColors.black
        heatIco.setImage(UIImage(systemName: "thermometer.medium"), for: .normal)
        heatIco.tintColor = AppColors.black
        gasIco.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        gasIco.tintColor = AppColors.black
        
        waterIco.translatesAutoresizingMaskIntoConstraints = false
        electricIco.translatesAutoresizingMaskIntoConstraints = false
        heatIco.translatesAutoresizingMaskIntoConstraints = false
        gasIco.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            waterIco.centerYAnchor.constraint(equalTo: styleView.centerYAnchor),
            electricIco.centerYAnchor.constraint(equalTo: styleView.centerYAnchor),
            heatIco.centerYAnchor.constraint(equalTo: styleView.centerYAnchor),
            gasIco.centerYAnchor.constraint(equalTo: styleView.centerYAnchor),
           
            waterIco.trailingAnchor.constraint(equalTo: electricIco.leadingAnchor, constant: -6),
            electricIco.trailingAnchor.constraint(equalTo: heatIco.leadingAnchor, constant: -6),
            heatIco.trailingAnchor.constraint(equalTo: gasIco.leadingAnchor, constant: -6),
            gasIco.trailingAnchor.constraint(equalTo: styleView.trailingAnchor, constant: -16),
        ])
    }
    private func setButtonStyle(style: BillButtonStyle) {
        switch style {
        case .rent:
            typeLabel.text = "Кварплата"
            pictureView.image = UIImage(resource: .billIco)
            dueDateLabel.text = "Оплатить до 20 Сентября"
            setupSumLabel()
        case .utility:
            typeLabel.text = "Показания счетчиков"
            dueDateLabel.text = "Отправить до 20 Сентября"
            pictureView.image = UIImage(resource: .utilityIco)
            setupCountersView()
        }
    }
    @objc private func buttonPressed() {
        guard let action = self.action else { return }
        action()
    }
}

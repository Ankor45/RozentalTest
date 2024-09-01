//
//  ServiceCollectionCell.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 01.09.2024.
//

import UIKit

class ServiceCollectionCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Download image
//    func configure(with projectInfo: (text: String, photoUrl: String)) {
//        titleLabel.text = projectInfo.text
//        let stringUrl = projectInfo.photoUrl
//        
//       
//        
//        guard let imageURL = URL(string: stringUrl) else { return }
//        
//        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
//            guard let self = self, let data = data, let photo = UIImage(data: data), error == nil else {
//                print("Error: \(String(describing: error?.localizedDescription))")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.photoImage.image = photo
//                self.imageCache.setObject(photo, forKey: stringUrl as AnyObject)
//            }
//        }.resume()
//    }
    
    func setupCell() {
        setupBacground()
        setupphotoImage()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupBacground() {
        contentView.backgroundColor = AppColors.white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOffset = .zero
    }
    
    // MARK: - Setup UI
    func setupphotoImage() {
        contentView.addSubview(imageView)
       // imageView.image = UIImage(resource: .utilityIco)
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4 ),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.text = "Title label"
        titleLabel.numberOfLines = .zero
        titleLabel.textColor = AppColors.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10)
        ])
    }
    
    func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.text = "description label"
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.textColor = AppColors.gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10)
        ])
    }
    
}


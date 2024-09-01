//
//  MainViewController.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 30.08.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Views
    private lazy var whiteView = UIView()
    private lazy var headerStack = UIStackView()
    private lazy var avatarImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var addressLabel = UILabel()
    private lazy var notificationButton = NotificationButton()
    private lazy var dateLabel = UILabel()
    private lazy var companyMessageButton = UIButton()
    private lazy var rentButton = BillButton()
    private lazy var utilityButton = BillButton()
    private lazy var camsButton = SquareButton()
    private lazy var barrierButton = SquareButton()
    private lazy var proposalButton = SquareButton()
    private lazy var allServicesButton = RozentalButton()
    
    private lazy var servicesCollection: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 10
        layout.itemSize = .init(width: 290, height: 80)
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let count = 3
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.blue
        setupUI()
    }
}

// MARK: - Layot
extension MainViewController {
    func setupUI() {
        setupWhiteView()
        setupHeaderStack()
        setupAvatarImageView()
        setupNameLabel()
        setupAddressLabel()
        setupNotificationButton()
        setupDateLabel()
        setuoCompanyMessageLabel()
        setupBillButton()
        setupUtilityButton()
        setupServicesCollection()
        setupBarrierButton()
        setupCamsButton()
        setupProposalButton()
        setupAllServicesButton()
    }
    
    private func setupHeaderStack() {
        view.addSubview(headerStack)
        headerStack.axis = .horizontal
        headerStack.addSubview(avatarImageView)
        headerStack.addSubview(nameLabel)
        headerStack.addSubview(addressLabel)
        headerStack.addSubview(notificationButton)
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerStack.bottomAnchor.constraint(equalTo: whiteView.topAnchor, constant: -6)
        ])
    }
    private func setupWhiteView() {
        view.addSubview(whiteView)
        whiteView.backgroundColor = AppColors.white
        whiteView.layer.cornerRadius = 24
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 5),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupAvatarImageView() {
        let image = UIImage(systemName: "person.circle.fill")
        avatarImageView.image = image
        avatarImageView.tintColor = AppColors.white
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: headerStack.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: headerStack.leadingAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func setupNameLabel() {
        nameLabel.text = "Name Lastname"
        nameLabel.textColor = AppColors.white
        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10)
        ])
    }
    private func setupAddressLabel() {
        addressLabel.text = "Address label"
        addressLabel.textColor = AppColors.white
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
    private func setupNotificationButton() {
        notificationButton.setCount(count: 5)
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notificationButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            notificationButton.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor, constant: -20),
        ])
    }
    private func setupDateLabel() {
        whiteView.addSubview(dateLabel)
        let date = "12 Апреля"
        let attributedString = NSMutableAttributedString(string: "Сегодня \(date)")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.black, range: NSRange(location: 0, length: 7))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.gray, range: NSRange(location: 8, length: date.count ))
        dateLabel.attributedText = attributedString
        dateLabel.font = .boldSystemFont(ofSize: 30)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20)
        ])
    }
    private func setuoCompanyMessageLabel() {
        whiteView.addSubview(companyMessageButton)
        let count: Int = count
        companyMessageButton.setTitle("\(count) Сообщения от УК", for: .normal)
        companyMessageButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        companyMessageButton.setTitleColor(AppColors.black, for: .normal)
        companyMessageButton.backgroundColor = AppColors.white
        companyMessageButton.layer.cornerRadius = 12
        companyMessageButton.layer.shadowOpacity = 0.3
        companyMessageButton.layer.shadowRadius = 3
        companyMessageButton.layer.shadowOffset = .zero
        companyMessageButton.translatesAutoresizingMaskIntoConstraints = false
        
        let redPoint = UIImageView()
        companyMessageButton.addSubview(redPoint)
        redPoint.image = UIImage(systemName: "circlebadge.fill")
        redPoint.tintColor = AppColors.red
        redPoint.isHidden = count > 0 ? false : true
        redPoint.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            companyMessageButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 10),
            companyMessageButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 6),
            companyMessageButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -6),
            companyMessageButton.heightAnchor.constraint(equalToConstant: 60),
            redPoint.centerYAnchor.constraint(equalTo: companyMessageButton.centerYAnchor),
            redPoint.trailingAnchor.constraint(equalTo: companyMessageButton.trailingAnchor, constant:  -20)
        ])
        companyMessageButton.titleLabel?.leadingAnchor.constraint(equalTo: companyMessageButton.leadingAnchor, constant: 16).isActive = true
    }
    private func setupBillButton() {
        whiteView.addSubview(rentButton)
        rentButton.style = .rent
        rentButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rentButton.topAnchor.constraint(equalTo: companyMessageButton.bottomAnchor, constant: 6),
            rentButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 6),
            rentButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -6),
            rentButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    private func setupUtilityButton() {
        whiteView.addSubview(utilityButton)
        utilityButton.style = .utility
        utilityButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            utilityButton.topAnchor.constraint(equalTo: rentButton.bottomAnchor, constant: 6),
            utilityButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 6),
            utilityButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -6),
            utilityButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    private func setupServicesCollection() {
        whiteView.addSubview(servicesCollection)
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
        servicesCollection.register(ServiceCollectionCell.self, forCellWithReuseIdentifier: "ServiceCollectionCell")
        servicesCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            servicesCollection.topAnchor.constraint(equalTo: utilityButton.bottomAnchor, constant: 8),
            servicesCollection.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor),
            servicesCollection.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor),
            servicesCollection.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    private func setupBarrierButton() {
        whiteView.addSubview(barrierButton)
        barrierButton.type = .barrier
        barrierButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            barrierButton.topAnchor.constraint(equalTo: servicesCollection.bottomAnchor, constant: 10),
            barrierButton.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            barrierButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3.3),
            barrierButton.heightAnchor.constraint(equalTo: barrierButton.widthAnchor)
        ])
    }
    private func setupCamsButton() {
        whiteView.addSubview(camsButton)
        camsButton.type = .cam
        camsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            camsButton.topAnchor.constraint(equalTo: servicesCollection.bottomAnchor, constant: 10),
            camsButton.trailingAnchor.constraint(equalTo: barrierButton.leadingAnchor, constant: -8),
            camsButton.widthAnchor.constraint(equalTo: barrierButton.widthAnchor),
            camsButton.heightAnchor.constraint(equalTo: barrierButton.widthAnchor)
        ])
    }
    private func setupProposalButton() {
        whiteView.addSubview(proposalButton)
        proposalButton.type = .proposal
        proposalButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            proposalButton.topAnchor.constraint(equalTo: servicesCollection.bottomAnchor, constant: 10),
            proposalButton.leadingAnchor.constraint(equalTo: barrierButton.trailingAnchor, constant: 8),
            proposalButton.widthAnchor.constraint(equalTo: barrierButton.widthAnchor),
            proposalButton.heightAnchor.constraint(equalTo: barrierButton.widthAnchor)
        ])
    }
    private func setupAllServicesButton() {
        whiteView.addSubview(allServicesButton)
        allServicesButton.scheme = .orange
        allServicesButton.setTitle("Все сервисы")
        allServicesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            allServicesButton.topAnchor.constraint(equalTo: barrierButton.bottomAnchor, constant: 10),
            allServicesButton.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 8),
            allServicesButton.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -8),
            allServicesButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionCell", for: indexPath)
        return cell
    }
}

#Preview {
    MainViewController()
}

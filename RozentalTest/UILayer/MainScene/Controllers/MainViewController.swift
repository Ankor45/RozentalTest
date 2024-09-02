//
//  MainViewController.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 30.08.2024.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    let profile: Profile
    let count = 3
    //MARK: - Views
    let whiteView = UIView()
    let headerStack = UIStackView()
    let avatarImageView = UIImageView()
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let notificationButton = NotificationButton()
    let dateLabel = UILabel()
    let companyMessageButton = UIButton()
    let rentButton = BillButton()
    let utilityButton = BillButton()
    let camsButton = SquareButton()
    let barrierButton = SquareButton()
    let proposalButton = SquareButton()
    let allServicesButton = RozentalButton()
    
    let servicesCollection: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.headerReferenceSize = .zero
        layout.minimumLineSpacing = 10
        layout.itemSize = .init(width: 290, height: 90)
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
    //    MARK: - Initializers
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        let stringUrl = profile.photo
        guard let imageURL = URL(string: stringUrl) else { return }
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let self = self, let data = data, let photo = UIImage(data: data), error == nil else {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }
            DispatchQueue.main.async {
                self.avatarImageView.image = photo
            }
        }.resume()
        
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.layer.masksToBounds = true
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
        nameLabel.text = profile.name
        nameLabel.textColor = AppColors.white
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10)
        ])
    }
    private func setupAddressLabel() {
        addressLabel.text = profile.address
        addressLabel.textColor = AppColors.white
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
    private func setupNotificationButton() {
        notificationButton.setCount(count: profile.notification)
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notificationButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            notificationButton.trailingAnchor.constraint(equalTo: headerStack.trailingAnchor, constant: -20),
        ])
    }
    private func setupDateLabel() {
        whiteView.addSubview(dateLabel)
        let date = profile.date
        let attributedString = NSMutableAttributedString(string: "Сегодня \(date)")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.black, range: NSRange(location: 0, length: 7))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColors.gray, range: NSRange(location: 8, length: date.count ))
        dateLabel.attributedText = attributedString
        dateLabel.font = .boldSystemFont(ofSize: 24)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20)
        ])
    }
    private func setuoCompanyMessageLabel() {
        whiteView.addSubview(companyMessageButton)
        companyMessageButton.setTitle("5 Сообщений от УК", for: .normal)
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
            servicesCollection.heightAnchor.constraint(equalToConstant: 100)
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
        profile.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionCell", for: indexPath) as! ServiceCollectionCell
        let item = profile.banners[indexPath.row]
        cell.configure(text: item.title, description: item.text, photoUrl: item.image)
        return cell
    }
}

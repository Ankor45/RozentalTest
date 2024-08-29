//
//  LoginViewController.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 28.08.2024.
//

import UIKit

enum LoginViewState {
    case initial
    case signIn
}
protocol LoginViewInput: AnyObject {
    func startLoader()
    func stopLoader()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutput!
    
    //MARK: - Views
    private lazy var logoImage = UIImageView()
    private lazy var welcomeLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var signInButton = RozentalButton()
    private lazy var signUpButton = RozentalButton()
    private lazy var inviteFriendsButton = UIButton()
    private lazy var signInLabel = UILabel()
    private lazy var loginTextField = RozentalTextField()
    private lazy var passwordTextField = RozentalTextField()
    private lazy var loader = UIActivityIndicatorView(style: .large)
    private lazy var loaderContainer = UIView()
    
    //MARK: - Initializers
    init(viewOutput: LoginViewOutput, state: LoginViewState) {
        self.viewOutput = viewOutput
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.white
        setupUI()
    }
}

// MARK: - Layot
extension LoginViewController {
    func setupUI() {
        switch state {
        case .initial:
            setupLogoImage()
            setupWelcomeLabel()
            setupDescriptionLabel()
            setupSignInButton()
            setupSignUpButton()
            setupInviteFriendsButton()
        case .signIn:
            setupNavigationBar()
            setupSignInLabel()
            setupLoginTextField()
            setupPasswordTextField()
            setupSignInButton()
        }
        setupLoaderView()
    }
    func setupNavigationBar() {
        let backImage = UIImage(systemName: "chevron.left")
        
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.black
    }
    func setupLogoImage() {
        view.addSubview(logoImage)
        logoImage.image = UIImage(resource: .startScreen)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
    }
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        welcomeLabel.text = "Добро Пожаловать!"
        welcomeLabel.font = .boldSystemFont(ofSize: 46)
        welcomeLabel.numberOfLines = .zero
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
            welcomeLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3),
        ])
    }
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = "Авторизуйтесь, чтобы продолжить работу"
        descriptionLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.textColor = AppColors.lightGray
        descriptionLabel.numberOfLines = .zero
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
        ])
    }
    func setupSignInButton() {
        view.addSubview(signInButton)
        signInButton.setTitle("Войти")
        signInButton.scheme = .orange
        signInButton.action = { [weak self] in
            self?.onSignInTapped()
        }
        signInButton.translatesAutoresizingMaskIntoConstraints = false
       
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
                signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
                signInButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        case .signIn:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
                signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
                signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
                signInButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.setTitle("Регистрация")
        signUpButton.scheme = .white
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func setupInviteFriendsButton() {
        view.addSubview(inviteFriendsButton)
        let image = UIImage(systemName: "house")
        inviteFriendsButton.configuration = .plain()
        inviteFriendsButton.configuration?.imagePadding = 3
        inviteFriendsButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 11)
        inviteFriendsButton.setImage(image, for: .normal)
        inviteFriendsButton.setTitle("Пригласить управлять своим домом", for: .normal)
        inviteFriendsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inviteFriendsButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            inviteFriendsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
    }
    func setupSignInLabel() {
        view.addSubview(signInLabel)
        signInLabel.text = "Вход в аккаунт"
        signInLabel.font = .boldSystemFont(ofSize: 32)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6)
        ])
    }
    func setupLoginTextField() {
        view.addSubview(loginTextField)
        loginTextField.style = .email
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 6),
            loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
            loginTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
            loginTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.style = .password
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 6),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 6),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func setupLoaderView() {
        view.addSubview(loaderContainer)
        loaderContainer.backgroundColor = AppColors.black.withAlphaComponent(0.3)
        loaderContainer.isHidden = true
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loaderContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            loaderContainer.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        loaderContainer.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor)
        ])
    }
}

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInput {
    func startLoader() {
        loaderContainer.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoader() {
        loaderContainer.isHidden = true
        loader.stopAnimating()
    }
    
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput?.goToSignIn()
        case .signIn:
            viewOutput.loginStart()
        }
    }
}


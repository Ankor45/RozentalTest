//
//  LoginPresenter.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 30.08.2024.
//

import UIKit

protocol LoginViewOutput: AnyObject {
    func loginStart(login: String, password: String)
    func goToSignIn()
}

class LoginPresenter {
    private let userStorage = UserStorage.shared
    private var coordinator: LoginCoordinator?
    weak var viewInput: LoginViewInput?
    
    init(coordinator: LoginCoordinator? = nil, viewInput: LoginViewInput? = nil) {
        self.coordinator = coordinator
        self.viewInput = viewInput
    }
}

private extension LoginPresenter {
    func goToMainScreen() {
        coordinator?.finish()
    }
}

extension LoginPresenter: LoginViewOutput {
    func loginStart(login: String, password: String) {
        viewInput?.startLoader()
        authorize(username: login, password: password) { result in
            if result.code == 200 {
                fetchDashboard(login, password) { profile in
                    if profile.code == 200 {
                        self.userStorage.saveData = try! JSONEncoder().encode(profile)
                        DispatchQueue.main.async {
                            self.goToMainScreen()
                        }
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("Wrong email or password")
                    self.viewInput?.stopLoader()
                }
            }
        }
    }
    
    func goToSignIn() {
        coordinator?.showSignInScene()
    }
}

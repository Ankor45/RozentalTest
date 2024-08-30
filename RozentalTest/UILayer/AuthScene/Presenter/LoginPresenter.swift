//
//  LoginPresenter.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 30.08.2024.
//

import UIKit

protocol LoginViewOutput: AnyObject {
    func loginStart()
    func goToSignIn()
}

class LoginPresenter {
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
    func loginStart() {
        viewInput?.startLoader()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.goToMainScreen()
           
        }
       
    }
    
    func goToSignIn() {
        coordinator?.showSignInScene()
    }
}

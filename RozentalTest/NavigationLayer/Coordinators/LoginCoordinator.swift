//
//  LoginCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 28.08.2024.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    override func start() {
        showAuthScene()
    }
    
    override func finish() {
        print("LoginCoordinator finish")
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
       
    }
}

extension LoginCoordinator {
    func showAuthScene() {
        guard let navigationController = navigationController else { return }
        let presenter = LoginPresenter(coordinator: self)
        let controller = LoginViewController(viewOutput: presenter, state: .initial)
        presenter.viewInput = controller
        navigationController.pushViewController(controller, animated: true)
    }
    func showSignInScene() {
        guard let navigationController = navigationController else { return }
        let presenter = LoginPresenter(coordinator: self)
        let controller = LoginViewController(viewOutput: presenter, state: .signIn)
        presenter.viewInput = controller
        navigationController.pushViewController(controller, animated: true)
    }
}


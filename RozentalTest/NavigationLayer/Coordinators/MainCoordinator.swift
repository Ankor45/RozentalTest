//
//  MainCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    private let userStorage = UserStorage.shared
    
    override func start() {
        
        showMainScene()
    }
    
    override func finish() {
        print("MainCoordinator finish")
    }
}

extension MainCoordinator {
    func showMainScene() {
        guard let navigationController = navigationController else { return }
        if let data = userStorage.saveData {
            do {
                let profile = try? JSONDecoder().decode(Profile.self, from: data)
                let controller = MainViewController(profile: profile!)
                navigationController.pushViewController(controller, animated: true)
            }
        }
    }
}

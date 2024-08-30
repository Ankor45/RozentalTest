//
//  MainCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
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
        let controller = ViewController()
        navigationController.pushViewController(controller, animated: true)
    }
}

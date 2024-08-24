//
//  MainCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }
    override func finish() {
        print("MainCoordinator finish")
    }
}

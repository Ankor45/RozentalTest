//
//  RequestsCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class RequestsCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
    }
    override func finish() {
        print("RequestsCoordinator finish")
    }
}

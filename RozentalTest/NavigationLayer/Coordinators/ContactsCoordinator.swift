//
//  ContactsCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class ContactsCoordinator: Coordinator {
    
    override func start() {
        let vc = ViewController()
        vc.view.backgroundColor = .orange
        navigationController?.pushViewController(vc, animated: true)
    }
    override func finish() {
        print("ContactsCoordinator finish")
    }
}

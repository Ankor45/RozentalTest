//
//  ViewController.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 23.08.2024.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        authorize(username: API.username, password: API.password) { data in
//            print(data)
//        }
       
        
        
        let label = UILabel()
        label.text = "Test text"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100)
        ])
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = AppColors.gray
        
        view.backgroundColor = AppColors.buttonOrange
    }


}


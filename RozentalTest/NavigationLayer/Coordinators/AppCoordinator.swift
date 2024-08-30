//
//  AppCoordinator.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 24.08.2024.
//

import UIKit

class AppCoordinator: Coordinator, TabBarCoordinator {
    
    var tabBarController: UITabBarController?
    
    override func start() {
        showAuthFlow()
//        showMainFlow()
    }
    
}

// MARK: - Navigation methods
private extension AppCoordinator {
    func showMainFlow() {
        
        let mainNavigatorController = UINavigationController()
        let mainCoordinator = MainCoordinator(typs: .main, navigationController: mainNavigatorController)
        mainNavigatorController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "key.horizontal.fill"), tag: 0)
        mainCoordinator.finishDelegate = self
        mainCoordinator.start()
        
        let requestsNavigatorController = UINavigationController()
        let requestsCoordinator = RequestsCoordinator(typs: .requests, navigationController: requestsNavigatorController)
        requestsNavigatorController.tabBarItem = UITabBarItem(title: "Заявки", image: UIImage(systemName: "checkmark.rectangle.stack.fill"), tag: 1)
        requestsCoordinator.finishDelegate = self
        requestsCoordinator.start()
        
        let servicesNavigatorController = UINavigationController()
        let servicesCoordinator = ServicesCoordinator(typs: .services, navigationController: servicesNavigatorController)
        servicesNavigatorController.tabBarItem = UITabBarItem(title: "Услуги", image: UIImage(systemName: "star.fill"), tag: 2)
        servicesCoordinator.finishDelegate = self
        servicesCoordinator.start()
        
        let chatNavigatorController = UINavigationController()
        let chatCoordinator = ChatCoordinator(typs: .chat, navigationController: chatNavigatorController)
        chatNavigatorController.tabBarItem = UITabBarItem(title: "Чат", image: UIImage(systemName: "text.bubble.fill"), tag: 3)
        chatCoordinator.finishDelegate = self
        chatCoordinator.start()
        
        let contactsNavigatorController = UINavigationController()
        let contactsCoordinator = ContactsCoordinator(typs: .contacts, navigationController: contactsNavigatorController)
        contactsNavigatorController.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(systemName: "person.crop.square.fill"), tag: 4)
        contactsCoordinator.finishDelegate = self
        contactsCoordinator.start()
        
        
        addChildCoordinator(mainCoordinator)
        addChildCoordinator(requestsCoordinator)
        addChildCoordinator(servicesCoordinator)
        addChildCoordinator(chatCoordinator)
        addChildCoordinator(contactsCoordinator)
        
        let tabBarControllers = [mainNavigatorController, requestsNavigatorController, servicesNavigatorController, chatNavigatorController, contactsNavigatorController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        
        self.tabBarController = tabBarController
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        self.window?.layer.add(transition, forKey: kCATransition)
        self.window?.rootViewController = self.tabBarController

    }
    
    func showAuthFlow() {
        guard let navigationController = navigationController else { return }
        let loginCoordinator = LoginCoordinator(typs: .login, navigationController: navigationController,finishDelegate: self)
        loginCoordinator.start()
    }
}
// MARK: - FinishDelegate
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        removeChildCoordinator(childCoordinator)

        switch childCoordinator.type {
        case .login:
          
            showMainFlow()
            
            navigationController?.viewControllers = [navigationController?.viewControllers.last ?? UIViewController()]
        case .app:
            return
        default:
            navigationController?.popViewController(animated: false)
        }
    }
}

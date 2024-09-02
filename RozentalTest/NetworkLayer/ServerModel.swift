//
//  ServerModel.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 01.09.2024.
//

import Foundation
// MARK: - Answer
struct Answer: Codable {
    let code: Int
}
// MARK: - Profile
struct Profile: Codable {
    let code: Int
    let address: String
    let name: String
    let photo: String
    let notification: Int
    let date: String
    let banners: [Banner]
}
// MARK: - CustomerDashboard
struct CustomerDashboard: Codable {
    let customerDashboard: CustomerDashboardClass
    let code: Int
    let myProfile: MyProfile
    let myNewNotifications: Int
    
    enum CodingKeys: String, CodingKey {
        case customerDashboard = "customer_dashboard"
        case code
        case myProfile = "my_profile"
        case myNewNotifications = "my_new_notifications"
    }
}
// MARK: - CustomerDashboardClass
struct CustomerDashboardClass: Codable {
    let notifications: Notifications
    let banners: [Banner]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case notifications
        case banners, date
    }
}
// MARK: - Banner
struct Banner: Codable {
    let action: String
    let title: String
    let image: String
    let priority: Int
    let text: String
}
// MARK: - Notifications
struct Notifications: Codable {
    let count: Int
}
// MARK: - MyProfile
struct MyProfile: Codable {
    let address: String
    let name: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case name, photo
    }
}


//
//  networkTest.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 23.08.2024.
//

import Foundation

private func createRequest(_ username: String,_ password: String, for service: [String: Any]) -> URLRequest? {
    let serverURL = "https://test.rozentalgroup.ru/version2/entry.php"
    guard let url = URL(string: serverURL) else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let loginString = "\(username):\(password)"
    let loginData = loginString.data(using: .utf8)!
    let base64LoginString = loginData.base64EncodedString()
    request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    
    let boundary = UUID().uuidString
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    var body = Data()
    
    for (key, value) in service {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(value)\r\n".data(using: .utf8)!)
    }
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    request.httpBody = body
    return request
}
// MARK: - Authorize
func authorize(username: String, password: String, completion: @escaping (Answer) -> Void) {
    let service: [String: Any] = [
        "service[0][name]": "login",
        "service[0][attributes][login]": username,
        "service[0][attributes][password]": password,
        "service[1][name]": "customer_navbar"
    ]
    
    guard let request = createRequest(username, password, for: service) else { return }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error during authorization: \(error)")
            return
        }
        if let jsonData: Data = data  {
            
            if let answer = decodeServerAnswer(from: jsonData) {
                completion(answer)
            } else {
                print("Не удалось декодировать данные.")
            }
        }
    }
    task.resume()
}

private func decodeServerAnswer(from data: Data) -> Answer? {
    do {
        let serverAnswer = try JSONDecoder().decode(Answer.self, from: data)
        return serverAnswer
    } catch {
        print("Ошибка декодирования: \(error)")
        return nil
    }
}
// MARK: - Fetch Dashboard
func fetchDashboard(_ username: String,_ password: String, completion: @escaping (Profile) -> Void)  {
    let service: [String: Any] = [
        "service[0][name]": "customer_dashboard",
        "service[1][name]": "my_profile",
        "service[2][name]": "my_new_notifications"
    ]
    
    guard let request = createRequest(username, password, for: service) else { return }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching dashboard: \(error)")
        }
        if let jsonData: Data = data  {
            if let customerDashboard = decodeCustomerDashboard(from: jsonData) {
                completion(
                    Profile(
                        code: customerDashboard.code,
                        address: customerDashboard.myProfile.address,
                        name: customerDashboard.myProfile.name,
                        photo: customerDashboard.myProfile.photo,
                        notification: customerDashboard.myNewNotifications,
                        date: customerDashboard.customerDashboard.date,
                        banners: customerDashboard.customerDashboard.banners
                    )
                )
            } else {
                print("Не удалось декодировать данные.")
            }
        }
    }
    task.resume()
}

private func decodeCustomerDashboard(from data: Data) -> CustomerDashboard? {
    do {
        let customerDashboard = try JSONDecoder().decode(CustomerDashboard.self, from: data)
        return customerDashboard
    } catch {
        print("Ошибка декодирования: \(error)")
        return nil
    }
}

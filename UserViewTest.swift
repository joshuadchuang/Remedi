//
//  UserViewTest.swift
//  RemediApp
//
//  Created by Albert Su on 10/29/23.
//

import SwiftUI

struct UserViewTest: View {
    @State private var uniqueCode: String = ""
    @State private var userName: String = ""

    var body: some View {
        VStack {
            TextField("Enter User ID", text: $uniqueCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Get Unique Code") {
                // Send a GET request to the Vapor backend
                fetchUserName(uniqueCode: uniqueCode)
            }
            .padding()

            Text("User's Unique Code: \(userName)")
                .padding()
            
            Button("Update Unique Code") {
                // Send a GET request to the Vapor backend
                updateUser()
            }
            .padding()
        }
    }

    func fetchUserName(uniqueCode: String) {
        let baseUrl = "http://localhost:8080"
        
        guard let url = URL(string: "\(baseUrl)/user/\(uniqueCode)") else {
            // Handle URL creation error
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle network error
                print("Error: \(error)")
            } else if let data = data {
                do {
                    print("start decode")
                    print(print(String(data: data, encoding: .utf8)))
                    let user = try JSONDecoder().decode(User.self, from: data)
                    // Assuming you receive a User object from the server
                    print(userName)
                    userName = user.name
                } catch {
                    // Handle decoding error
                    print("Decoding Error: \(error)")
                }
            }
        }.resume()
    }
    
    func updateUser() {
        let baseUrl = "http://localhost:8080"
        
        guard let url = URL(string: "\(baseUrl)/user/") else {
            // Handle invalid URL
            return
        }
            
            // Prepare the PUT request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Create a dictionary with the data you want to send in the request body
        let user = User(uniqueCode: "1234567", name: "old man 2", medications: [])
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(user)
        } catch {
            // Handle JSON encoding error
            print("Error encoding user as JSON: \(error)")
            return
        }
        
            // Set the request headers if needed
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    // Handle network error
                    print("Error: \(error)")
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    // Successful update
                    print("User updated successfully.")
                } else {
                    // Handle non-200 response codes
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error message: \(errorMessage)")
                    } else {
                        print("Unknown error")
                    }
                }
            }
            
            task.resume()
        }
}

struct UserViewTest_Previews: PreviewProvider {
    static var previews: some View {
        UserViewTest()
    }
}




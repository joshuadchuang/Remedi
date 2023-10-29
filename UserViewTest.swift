//
//  UserViewTest.swift
//  RemediApp
//
//  Created by Albert Su on 10/29/23.
//

import SwiftUI

import SwiftUI

struct UserViewTest: View {
    @State private var uniqueCode: String = ""
    @State private var userUniqueCode: String = ""

    var body: some View {
        VStack {
            TextField("Enter User ID", text: $uniqueCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Get Unique Code") {
                // Send a GET request to the Vapor backend
                fetchUserUniqueCode()
            }
            .padding()

            Text("User's Unique Code: \(userUniqueCode)")
                .padding()
        }
    }

    func fetchUserUniqueCode() {
        guard let url = URL(string: "https://yourvaporbackend.com/api/user/\(uniqueCode)") else {
            // Handle URL creation error
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Handle network error
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    // Assuming you receive a User object from the server
                    userUniqueCode = user.uniqueCode
                } catch {
                    // Handle decoding error
                    print("Decoding Error: \(error)")
                }
            }
        }.resume()
    }
}

struct UserViewTest_Previews: PreviewProvider {
    static var previews: some View {
        UserViewTest()
    }
}




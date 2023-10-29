//
//  UserViewTest.swift
//  RemediApp
//
//  Created by Albert Su on 10/29/23.
//

import SwiftUI

struct UserViewTest: View {
    @State private var uniqueCode: String = ""

    var body: some View {
        VStack {
            TextField("Enter User ID", text: $uniqueCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Get Unique Code") {
                // Send a GET request here to fetch the user's data.
                // You can use URLSession or a networking library to make the request.

                // For this example, we'll simulate a user object.
                let user = User(uniqueCode: "123456", )
                self.uniqueCode = user.uniqueCode
            }
            .padding()

            Text("User's Unique Code: \(uniqueCode)")
                .padding()
        }
    }
}

struct UserViewTest_Previews: PreviewProvider {
    static var previews: some View {
        UserViewTest()
    }
}



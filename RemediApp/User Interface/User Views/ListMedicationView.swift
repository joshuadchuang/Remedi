//
//  ListMedicationView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct ListMedicationView: View {
    
    @State private var medications = [
        getAllMedications()
]
    
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                ForEach(medications) { medication in
                    NavigationLink(destination: MedicationInfoView(medication: medication)) {
                        MedicationView(medication: medication)
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes the default button style
                }
            }
        }
    }
}

struct ListMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        ListMedicationView().environmentObject(AppViewModel())
    }
}

func fetchUserData(userId: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    // Define the base URL of your Vapor backend running on localhost
    let baseUrl = "http://localhost:8080"
    
    // Create a URL object
    if let url = URL(string: "\(baseUrl)/user/\(userId)") {
        // Create a URLSession
        let session = URLSession.shared
        
        // Create a data task to perform the GET request
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Check if there's data in the response
            if let data = data {
                do {
                    // Parse the JSON response if it's in JSON format
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(json, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }
        
        // Start the data task
        task.resume()
    } else {
        let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        completion(nil, error)
    }
}

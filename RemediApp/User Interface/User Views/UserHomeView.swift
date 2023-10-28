//
//  UserHomeView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct UserHomeView: View {
    @State private var medications = [
        Medication(name: "Aspirin", time: Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!, dosage: "2 pills"),
        Medication(name: "Vitamin C", time: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, dosage: "1 pill")
    ]

    var body: some View {
        VStack {
            Text("Today's Date: \(formatDate(Date()))")
                .font(.headline)
                .padding()

            List {
                ForEach(medications) { medication in
                    MedicationView(medication: medication)
                }
                
                NavigationLink(destination: AddMedicationView()) {
                    Text("Add Medication")
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            HStack {
                NavigationLink(destination: ListMedicationView()) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: "list.bullet"))
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                
                Spacer()
                
                NavigationLink(destination: ProfileView()) {
                    Circle()
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: "person.crop.circle"))
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
            }
            .padding()
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct MedicationView: View {
    var medication: Medication

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(medication.timeFormatted)
                    .font(.system(size: 24))
                    .frame(width: 100, alignment: .leading)
                
                Spacer()
            }
            
            VStack(alignment: .trailing) {
                Text(medication.name)
                    .font(.headline)
                    .frame(width: 100, alignment: .trailing)
                
                Spacer()
            }
            
            VStack {
                Text(medication.dosage)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
        }
        .frame(height: 100)
        .padding()
    }
}

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserHomeView()
    }
}

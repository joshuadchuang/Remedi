//
//  UserHomeView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct UserHomeView: View {
    @EnvironmentObject var viewModel: AppViewModel

    @State private var medications = [
        Medication(name: "Aspirin", time: Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!, dosage: "2 pills"),
        Medication(name: "Vitamin C", time: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, dosage: "1 pill"),
        Medication(name: "Ibuprofen", time: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!, dosage: "1 pill")
    ]

    var body: some View {
        VStack {
            Text("Today's Date: \(formatDate(Date()))")
                .font(.headline)
                .padding()

            ScrollView {
                ForEach(medications.filter { $0.time >= Date() }) { medication in
                    Button(action: {
                        viewModel.selectedMedication = medication
                    }) {
                        MedicationView(medication: medication)
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes the default button style
                    .background(
                        NavigationLink("", destination: MedicationInfoView(medication: medication).environmentObject(viewModel))
                    )
                }
                
                NavigationLink(destination: AddMedicationView()) {
                    AddMedicationBlock()
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

struct UserHomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserHomeView().environmentObject(AppViewModel())
    }
}

//
//  Medication Input Form.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct MedicationInputForm: View {
    @State private var medicationName = ""
    @State private var medicationDosage = ""
    @State private var medicationTime = Date()
    
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Medication Name", text: $medicationName)
                    TextField("Dosage", text: $medicationDosage)
                    DatePicker("Time", selection: $medicationTime, displayedComponents: .hourAndMinute)
                }

                /*Button("Save") {
                    // Create a Medication object with user input
                    let newMedication = Medication(
                        id: UUID(),
                        name: medicationName,
                        time: medicationTime,
                        dosage: medicationDosage
                    )*/
                    
                NavigationLink(destination: AddMedicationView().environmentObject(viewModel)) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                let newMedication = Medication(
                    id: UUID(),
                    name: medicationName,
                    time: medicationTime,
                    dosage: medicationDosage)

                    // Handle the newMedication object (e.g., save to database)
                    // You can replace this with your backend logic.
                    //print("New Medication:", newMedication)
                }
            }
            .navigationTitle("Add Medication")
        }
    }

struct MedicationInputForm_Previews: PreviewProvider {
    static var previews: some View {
        MedicationInputForm()
    }
}

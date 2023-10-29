//
//  MedicationInfoView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct MedicationInfoView: View {
    var medication: Medication

    var body: some View {
        VStack {
            Text("Name: \(medication.name)")
                .font(.largeTitle)
                .padding()
            
            Text("Dosage: \(medication.dosage)")
                .padding()
            
            Text("Start Date: \(medication.startDate, style: .date)")
                .padding()
            
            Text("Frequency Per Day: \(medication.frequencyPerDay) times")
                .padding()
            
            Text("Duration: \(medication.duration) days")
                .padding()
        }
    }
}

struct MedicationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationInfoView(medication: Medication(name: "Sample Medication", time: Date(), dosage: "1 pill", startDate: Date(), frequencyPerDay: 2, duration: 7))
    }
}


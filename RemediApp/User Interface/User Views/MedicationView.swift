//
//  MedicationView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct MedicationView: View {
    var medication: Medication

    var body: some View {
        VStack {
            HStack {
                Text(medication.name)
                    .font(.system(size: 24))
                    .frame(width: 100, alignment: .leading)
            }
            
            Text("Dosage: \(medication.dosage)")
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(height: 100)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct MedicationView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationView(medication: Medication(name: "Medicine Name", time: Date(), dosage: "2 pills", startDate: Date(), frequencyPerDay: 2, duration: 7))
    }
}


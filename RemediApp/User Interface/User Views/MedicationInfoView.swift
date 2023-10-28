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
            Text(medication.name)
                .font(.largeTitle)
                .padding()
            
            Text("Time: \(medication.timeFormatted)")
                .font(.headline)
                .padding()
            
            Text("Dosage: \(medication.dosage)")
                .padding()
        }
    }
}

struct MedicationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationInfoView(medication: Medication(name: "Sample Medication", time: Date(), dosage: "1 pill"))
    }
}

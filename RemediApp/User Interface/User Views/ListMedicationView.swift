//
//  ListMedicationView.swift
//  RemediApp
//
//  Created by Joshua Chuang on 10/28/23.
//

import SwiftUI

struct ListMedicationView: View {
    @State private var medications = [
        Medication(name: "Aspirin", time: Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: Date())!, dosage: "2 pills"),
        Medication(name: "Vitamin C", time: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!, dosage: "1 pill"),
        Medication(name: "Ibuprofen", time: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!, dosage: "1 pill")
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

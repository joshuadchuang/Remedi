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
        Medication(name: "Aspirin", time: Date(), dosage: "2 pills", startDate: Date(), frequencyPerDay: 1, duration: 7),
        Medication(name: "Vitamin C", time: Date(), dosage: "1 pill", startDate: Date(), frequencyPerDay: 1, duration: 30),
        Medication(name: "Ibuprofen", time: Date(), dosage: "1 pill", startDate: Date(), frequencyPerDay: 1, duration: 14)

    ]

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("Today's Date: \(formatDate(Date()))")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                
                ScrollView {
                    ForEach(medications.filter { $0.time >= Date() }) { medication in
                        NavigationLink(destination: MedicationInfoView(medication: medication)) {
                            MedicationView(medication: medication)
                        }
                    }
                }




                
                Spacer()
                
                HStack {
                    
                    NavigationLink(destination: ListMedicationView()) {
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .foregroundStyle(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .overlay(Image(systemName: "list.bullet")
                                .resizable()
                                .foregroundStyle(LinearGradient(gradient:
                                    Gradient(colors: [Color("OceanBlue"), Color("GrassGreen")]),
                                    startPoint: .topLeading,
                                    endPoint:.bottomTrailing))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40))
                            
                    }
                    
                    NavigationLink(destination: AddMedicationView().environmentObject(viewModel)) {
                        AddMedicationBlock()
                    }
                    
                    NavigationLink(destination: ProfileView()) {
                        Rectangle()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .overlay(Image(systemName: "person.crop.circle")
                                .resizable()
                                .foregroundStyle(LinearGradient(gradient:
                                    Gradient(colors: [Color("OceanBlue"), Color("GrassGreen")]),
                                    startPoint: .topLeading,
                                    endPoint:.bottomTrailing))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40))
                    }
                }
            .padding()
        }
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
